use context starter2024
# leap-year :: Number -> Boolean
fun leap-year(year :: Number) -> Boolean:
  doc: "Takes into account a year and returns true if it is a leap year: Which is divisible by 4, except century years, which must also be divisible by 400"
  (num-modulo(year, 4) == 0) and
  ((num-modulo(year, 100) <> 0) or (num-modulo(year, 400) == 0))
where:
  # regular leap years (divisible by 4, not by 100)
  leap-year(2024) is true
  leap-year(1996) is true
  
  # regular non leap years(not divisble by 4)
  leap-year(2026) is false
  leap-year(2017) is false
  
  # Century years not divisble by 400 -> not leap years
  leap-year(1900) is false
  leap-year(2100) is false
  
  # Century years divisble by 400 -> leap years
  
  leap-year(2000) is true
  leap-year(1600) is true
  
end

#Problem 2
fun tick(s :: Number) -> Number:
  doc: " Takes into the account any whole number only from 0 to 59 and returns the next second wrapping from 0 to 59 seconds like a clock"
  
  if s == 59:
    0
  else:
    s + 1
  end
  
where:
  
# start of range is 
  tick(0) is 1
  
  # ordinary values in the middle
  tick(1) is 2
  tick(30) is 31
  tick(57) is 58
  
  # edge of range is
  tick(58) is 59
  
  # end of range and it wraps back to 0
  tick(59) is 0
end


#Problem 3
fun valid-choice(c :: String)-> Boolean:
  doc:"Returnd