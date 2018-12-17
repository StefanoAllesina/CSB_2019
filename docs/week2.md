## Summary of Chapter 3

- Programming in Python

- Many programming languages are available. Pick at least 3:
     - One for prototyping, simple tasks (my lab: `Python`)
     - One for stats and plotting (my lab: `R`)
     - One for large-scale simulations and computing-intensive tasks (my lab: `C`)

- We use jupyter, because it looks the same on any architecture

- Open a terminal, go to the `week2/sandbox`, and type `jupyter notebook`

### Assignment

Take whatever is on the right and put it in a "box"; label the box with the name on the left.

```python
x = 6 # create a box containing the int 6 and call it x
```

How do we test for equality?

```python
2 * 3 == 6
```

### Basic data types

- To determine the type of a variable, call `type(x)`
- `int`: integers (positive or negative) `x = 6`
- `float`: floating-point representation of real numbers `x = 6.0`
- `str`: characters or strings `x = 'ciao'`
- `bool`: `True/False` (Boolean) `y = 7 > 5`

### Operators

```python
x = 5
y = 3

x + y # addition
x - y # subtraction
x * y # multiplication
x / y # division
x ** y # exponentiation x^y
x // y # integer division
x % y # modulo (remainder integer division)

x == y # equals
x != y # differs
x > y # greater than
x <= y # lower or equal

a = True
b = False

a & b # and
a and b
a | b # or
a or b
!b # not b

# precedence
2 * 3 ** 3 == 54
# better use parentheses
(2 * 3) ** 3 == 216
```

### Types in Python

- Dynamic typing: the type of a variable is determined at runtime. 
- Casting: you can change the variable type (if sensible).
- Object oriented: each type comes with a set of functions (*methods*).
- To see the variables (and functions) you've created, type `who`

```python
x = 8 # now x is an integer
x = x / 2
print(x)

y = "77" # this is a string
x + int(y) # cast to integer

x = "a string"
print("now x is", x)

# see all methods available for stings
dir(x)
x.upper()
```



- Look at the first few lines to familiarize yourself with the data

<details>
 <summary>Solution</summary>

```
head European_Red_List.csv
```

</details>

