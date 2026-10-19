use context dci2024
#TASK 1 PLANNING
#INPUTS(columns used):
#tailnum, dep_delay, arr_delay, flight, carrier, dep_time
#(plus distance and air_time for Tasks 3 and 4)
#
# OUTPUTS:
#A cleaned table (no missing tailnums, no negative delays,
#consistent carrier codes, HH:MM times, a dedup_key column)
#A count of duplicate entries per dedup_key
#Visualisations + summary statistics (Task 4)

# Problem 1 is some tailnum entries are missing and so replace with "UNKNOWN"
# Problem 2 is dep_delay and arr_delay contain negative values (early flights) so replace it with 0
# Problem 3 is carrier has extra spaces and lowercase letters so trim the spaces and make it uppercase
# Problem 4 is dep_time is a raw number like 517 and not a proper readable time so convert it to one ("HH:MM") 517 to "05:17"
# Problem 5 is the table may contain duplicate flights so build a dedup_key "flight-CARRIER-HH:MM" for each row and then group them into key groups
# Problem 6 is some distance and air_time values are unrealistic and filter them out (Task 3) and use (filter-with)

#Task 2 
# Column names match the header of flights 