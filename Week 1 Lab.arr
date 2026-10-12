use context starter2024
#Calculating Cost Expression 1
(5 * 12) + 3

#Expression 2
(7 * 12) + 3

# Rectangular Poster
perimeter = 2 * (420 + 594)
poster-cost = perimeter * 0.10
poster-cost

#2
#Tagline

tagline = "Designs for everyone!"
tagline

"red " + "blue"

#3

#Frame
body = rectangle(35, 100, "solid", "black")

#lights
red-light = circle(12, "solid", "red")

yellow-light = circle(12, "solid", "yellow")

green-light = circle(12, "solid", "green")

gap = rectangle(24, 6, "solid", "black")

lights = above(red-light,  above(gap, above(yellow-light, above(gap, green-light))))

traffic-light = overlay-align("center", "middle", lights, body)

pole = rectangle(10, 60, "solid", "dimgray")
full-light = above(traffic-light, pole)
full-light

#4
#Goal: A rectangle with width 50 and height 20, solid black
rectangle(50, 20,"solid", "black")

circle(30, "solid", "red")

#Create a Flag or Shield
#Flag Design
background = rectangle(300, 200, "solid", "red")

emblem = overlay(star(30, "solid", "Gold"), square(80,"solid","red"))

stripe = rectangle(60, 200, "solid", "gold")

with-emblem = overlay-align("left", "top", emblem,  background)

flag = overlay-align("right", "middle", stripe, with-emblem)
flag

#Shield variation
diamond = rotate(45, square(100, "solid", "gray"))

with-circle = overlay(circle(45, "solid", "darkred"), diamond)
shield = overlay(star(40, "solid", "gold"), with-circle)
shield

labelled-shield = overlay(text("Go!", 20, "black"), shield)
labelled-shield