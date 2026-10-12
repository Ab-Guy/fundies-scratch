use context dcic2024

include csv
include data-source

orders = table: time, amount
  row: "08:00", 10.50
  row: "9:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end


fun is-morning(o :: Row) -> Boolean:
  (o["time"] >= "00:00") and (o["12:00"] < "12:00")
where:
is-morning(orders.row-n(2)) is true
is-morning(orders.row-n(4)) is false
is-morning(orders.row-n(5)) is false
end

filter-with(orders, is-morning)

#name-less function
filter-with(orders, lam(o): (o["time"] >= "00:00") and (o["time"] < "12:00") end)

#order-by
orders-latest-first = order-by(orders, "time", false)




