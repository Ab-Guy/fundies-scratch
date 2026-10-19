use context starter2024
 import math as M
import statistics as S

cafe-data = table: day, coffee-sold
  row: "Mon", 45
  row: "Tue", 30
  row: "Wed", 55
  row: "Thu", 40
  row: "Fri", 60
end

sales = cafe-data.get-column("coffee-sold")

#statistics
S.mean(sales)
S.median(sales)

M.sum(sales)
M.max(sales)
M.min(sales)

#some operations on list
discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

unique-codes = distinct(discount-codes)

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end

real-code = filter(is-real-code, unique-codes)

lower-codes = map(string-to-lower, real-code)

map(is-real-code, map(string-to-lower, discount-codes))

distinct(filter(is-real-code, map(string-to-lower, discount-codes)))

var total = 1
total := total + 10
total #11

#for each
fun my-sum(num-list :: List) -> Number block:
  var running = 0
  for each(n from num-list):
    running := running + n
  end
  running
where:
  my-sum([list: 0, 1, 2, 3]) is 6
  my-sum([list: ]) is 0
end

my-sum(sales)

#produce a new list
fun add-two(numbers :: List<Number>) -> List<Number> block:
  var added-two = [list: ]
  for each(n from numbers):
    added-two := added-two.append([list: n + 2])
  end
  added-two
where:
  add-two([list: 1, 2, 3]) is [list: 3, 4, 5]
  add-two([list: 0]) is [list: 2]
end


#|
   fold walks thorugh a list and builds up one answer as it goes/Give it three things:
   1. starting value
   2. a rule
   3. the list
   
   fold(lam(acc, n): acc + n end, 0, [list: 45, 30, 55])
   answer so far: 0, 45, 75,
   next item: 45, 30, 55
   new answer: 45, 75, 130
   
|#

fun my-sum-fold(num-list :: List<Number>) -> Number:
  doc: "adds up the numbers in num-list"
  fold(lam(acc,n): acc + n end, 0, num-list)
where:
    my-sum-fold([list: 0, 1, 2, 3]) is 6
    my-sum-fold([list: ]) is 0
  end
  
fold(lam(acc, n): acc + n end, 0, [list: 45, 30, 55])

fun with-vat(prices :: List<Number>) -> List <Number> block:
  doc: "returns each price in a list with 20% VAT added"
  var final-prices = [list: ]
  for each(p from prices):
    final-prices := final-prices.append([list : p + (p * 0.2)])
  end
  final-prices
  
where:
  with-vat([list: 10, 50, 100]) is [list: 12, 60, 120 ]
  with-vat([list: ]) is [list: ]
end

with-vat(sales)

map(lam(p): p + (p * 0.2) end, sales)

     


