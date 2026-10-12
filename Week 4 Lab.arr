use context dcic2024
include csv
include data-source

flights = load-table: 
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  source: csv-table-url("https://raw.githubusercontent.com/Ab-Guy/fundies-scratch/main/flights.csv",default-options)
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
end

fun is_long_flight(row :: Row) -> Boolean:
  doc: "Will return it as true if the flight's distance is at least 1500"
  row["distance"] >= 1500
end

long-flights = filter-with(flights, is_long_flight)

by-air-time = order-by(long-flights, "air time", false)

top-row = by-air-time.row-n(0)
top-carrier = top-row ["carrier"]
top-origin = top-row ["origin"]
top-dest = top-row["dest"]