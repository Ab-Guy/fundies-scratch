use context dcic2024

include csv
include data-source

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

fun is-morning(o :: Row) -> Boolean:
  (o["time"] >= "00:00") and (o["time"] < "12:00")
where:
  is-morning(orders.row-n(1)) is true
  is-morning(orders.row-n(2)) is true
  is-morning(orders.row-n(4)) is false
  is-morning(orders.row-n(5)) is false
end

# morning orders using the named function
morning-orders = filter-with(orders, is-morning)

# same thing with a name-less function
filter-with(orders, lam(o): (o["time"] >= "00:00") and (o["time"] < "12:00") end)

# orders sorted latest to earliest
orders-latest-first = order-by(orders, "time", false)

# amount of the latest morning order
order-by(morning-orders, "time", false).row-n(0)["amount"]