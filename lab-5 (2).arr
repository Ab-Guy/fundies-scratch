use context dcic2024
# Week 5 Lab: Processing Tables & Lists
# (Set context to dcic2024 via the Pyret logo -> Choose Context, if the line above isn't enough)

# =====================================================================
# TASK 1 - TASK PLAN (for Task 2)
# =====================================================================
# INPUTS (columns used):
#   tailnum, dep_delay, arr_delay, flight, carrier, dep_time
#   (plus distance and air_time for Tasks 3 and 4)
#
# OUTPUTS:
#   - A cleaned table (no missing tailnums, no negative delays,
#     consistent carrier codes, HH:MM times, a dedup_key column)
#   - A count of duplicate entries per dedup_key
#   - Visualisations + summary statistics (Task 4)
#
# STEPS:
#   1. Problem: some tailnum values are empty ("").
#      Step: replace "" with "UNKNOWN".
#      Implementation: transform-column with a lambda.
#   2. Problem: dep_delay / arr_delay contain negative numbers (early flights).
#      Step: replace negatives with 0.
#      Implementation: transform-column with a lambda using if.
#   3. Problem: carrier has extra spaces and lowercase letters.
#      Step: trim spaces and convert to uppercase.
#      Implementation: transform-column with trim + string-to-upper.
#   4. Problem: dep_time is a raw number like 517, not a readable time.
#      Step: convert to "HH:MM" (517 -> "05:17").
#      Implementation: helper function using num-floor and num-modulo.
#   5. Problem: the table may contain duplicate flights.
#      Step: build a dedup_key "flight-CARRIER-HH:MM" for each row,
#      then group and count by that key.
#      Implementation: build-column, then group and count.
#   6. Problem: some distance / air_time values are unrealistic.
#      Step: filter them out (Task 3).
#      Implementation: filter-with.

# =====================================================================
# TASK 2 - LOAD, CLEAN, IDENTIFY DUPLICATES
# =====================================================================

# Column names match the header of flights_sample53.csv, in the same order
flights_53 = load-table: rownames, dep_time, sched_dep_time, dep_delay,
  arr_time, sched_arr_time, arr_delay, carrier, flight, tailnum, origin, dest,
  air_time, distance, hour, minute, time_hour
  source: csv-table-file("flights_sample53.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
  # tailnum and carrier stay as text
  sanitize tailnum using string-sanitizer
  sanitize carrier using string-sanitizer
end

# ---------- Helper functions ----------

# Trim spaces at both ends (helper given in the brief)
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
where:
  trim("  ua ") is "ua"
  trim("") is ""
end

fun fill-missing(s :: String) -> String:
  doc: "Return UNKNOWN if the string is empty, otherwise the string unchanged."
  if s == "":
    "UNKNOWN"
  else:
    s
  end
where:
  fill-missing("") is "UNKNOWN"
  fill-missing("N14228") is "N14228"
end

fun no-negative(n :: Number) -> Number:
  doc: "Replace a negative number with 0; keep other numbers as they are."
  if n < 0:
    0
  else:
    n
  end
where:
  no-negative(-5) is 0
  no-negative(12) is 12
  no-negative(0) is 0
end

fun clean-carrier(s :: String) -> String:
  doc: "Trim spaces and convert a carrier code to uppercase."
  string-to-upper(trim(s))
where:
  clean-carrier(" ua ") is "UA"
  clean-carrier("B6") is "B6"
end

fun pad2(n :: Number) -> String:
  doc: "Turn a number into a two-digit string, adding a leading 0 if needed."
  if n < 10:
    "0" + num-to-string(n)
  else:
    num-to-string(n)
  end
where:
  pad2(5) is "05"
  pad2(17) is "17"
end

fun format-time(t :: Number) -> String:
  doc: "Convert a time like 517 into HH:MM format, e.g. 05:17."
  # Dividing by 100 separates hours from minutes:
  # 517 / 100 = 5.17 -> floor gives 5 hours; remainder 17 is the minutes
  hours = num-floor(t / 100)
  mins = num-modulo(t, 100)
  pad2(hours) + ":" + pad2(mins)
where:
  format-time(517) is "05:17"
  format-time(1800) is "18:00"
  format-time(5) is "00:05"
end

# ---------- Step 1: missing tailnum -> "UNKNOWN" ----------
flights-tail = transform-column(flights_53, "tailnum",
  lam(s :: String) -> String: fill-missing(s) end)

# ---------- Step 2: negative delays -> 0 ----------
flights-dep = transform-column(flights-tail, "dep_delay",
  lam(n :: Number) -> Number: no-negative(n) end)
flights-delays = transform-column(flights-dep, "arr_delay",
  lam(n :: Number) -> Number: no-negative(n) end)

# Also tidy the carrier column itself so later grouping/mapping is consistent
flights-clean = transform-column(flights-delays, "carrier",
  lam(s :: String) -> String: clean-carrier(s) end)

# ---------- Step 3: dedup_key and duplicates ----------
# All three normalisations happen inside a single lam, as the hint asks
flights-keyed = build-column(flights-clean, "dedup_key",
  lam(r :: Row) -> String:
    num-to-string(r["flight"]) + "-"
      + clean-carrier(r["carrier"]) + "-"
      + format-time(r["dep_time"])
  end)

# Group rows that share the same key, and count how often each key appears
dup-groups = group(flights-keyed, "dedup_key")
dup-counts = count(flights-keyed, "dedup_key")

# Only the keys that appear more than once are actual duplicates
duplicates-only = filter-with(dup-counts, lam(r :: Row) -> Boolean: r["count"] > 1 end)

# =====================================================================
# TASK 3 (OPTIONAL) - CATEGORICAL VALUES AND OUTLIERS
# =====================================================================

fun airline-name(code :: String) -> String:
  doc: "Map a carrier code to the full airline name, or Other if unknown."
  ask:
    | code == "UA" then: "United Airlines"
    | code == "AA" then: "American Airlines"
    | code == "B6" then: "JetBlue"
    | code == "DL" then: "Delta Air Lines"
    | code == "EV" then: "ExpressJet"
    | code == "WN" then: "Southwest Airlines"
    | code == "OO" then: "SkyWest Airlines"
    | otherwise: "Other"
  end
where:
  airline-name("UA") is "United Airlines"
  airline-name("ZZ") is "Other"
end

flights-airline = build-column(flights-keyed, "airline",
  lam(r :: Row) -> String: airline-name(r["carrier"]) end)

# Outliers: distance > 5000 and air_time > 500 are unrealistic.
# (The brief says "< 500", but air_time is in minutes and every normal flight
# here is under 500. The real outliers in the data are rows 11 and 35,
# with air_time 2000/3000 and distance 10000/20000, so we keep <= 500.)
final-flights = filter-with(flights-airline,
  lam(r :: Row) -> Boolean:
    (r["distance"] <= 5000) and (r["air_time"] <= 500)
  end)

# =====================================================================
# TASK 4 - VISUALISATION & FOR EACH LOOP
# =====================================================================

# 1. Three visualisations
freq-bar-chart(final-flights, "airline")
histogram(final-flights, "distance", 250)   # last argument = bin width
scatter-plot(final-flights, "air_time", "distance")

# 2. Extract distance column as a list
distances = final-flights.get-column("distance")

# 3. Total, average and maximum using for each
var total = 0
var max-distance = 0

for each(d from distances):
  total := total + d
  when d > max-distance:
    max-distance := d
  end
end

average-distance = total / length(distances)

"Total distance flown:"
total
"Average distance:"
average-distance
"Maximum distance:"
max-distance
