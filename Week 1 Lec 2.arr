use context starter2024
sample_string = "Hello World"

# to check the length of string
string-length(sample_string)

#append
a = 'Hello '
b = 'World '

a + ' ' + b
c = a + ' ' + b
c


string-append('FC', 'Barcelona')
string-repeat(c,6)

long_string = "hello my name is james bond, id 007"

long_string

string-to-upper(long_string)
string-to-upper(long_string)

string-to-lower(long_string)

string-substring('Hello World', 5, 11)
string-length('Hello World') 
string-contains(long_string, "007")
search_query = string-to-lower(long_string)

string-contains(search_query, "james bond")



#images: shapes and composition
circle(30, "solid", "blue")

rectangle(80, 40, "solid" , "green")

triangle(50, "outline", "red" )

#composition
#overlay((first figure)), (second figure)
overlay(circle)(30,"solid", "blue"),
rectnagle(80, 60, "solid", "yellow")
  