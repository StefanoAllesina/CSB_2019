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
- `complex`: complex numbers `x = 3 + 2j`
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
not b

a in b # test for membership

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

### More on strings

```python
s = "my Test string"
len(s) # num characters
s + " is not longer" # concatenation
s.replace("my", "your") # replacement
s.split(" ") # split into list of strings
" space around string ".strip() # remove space on both ends
s.upper() # to uppercase
s.lower() # to lowercase
";".join(["a", "b", "c"]) # concatenate list of strings
```

### Data structures

List: ordered collection of values

```python
li = ["a", 13, True, ["a", "b"]]
li2 = list("abcdefg")
# indexing starts at 0
li[0]
li[4] # error!
# slice
li[:2]
# negative indices
li[-3:]
# mutable: you can overwrite values
li[3] = "bb"
# extend list
li.append(25)
# sort will sort in place
sort(li)
# combine lists
li + li2
# find element
li.index("a")
# insert/remove
li.insert(3, "to add")
li.remove("a")
# remove and return last element
x = li.pop()
# count occurrences
li.count(13)
# reverse in place
li.reverse()
```

Dictionaries: most pythonic data structure; key-value pairs.

```python
d = {'first': 'first value', 'second':[1,2]}
d.keys() # access keys
d.values() # access values

```

Tuples: unmutable lists

Sets: no duplicates

### Some built-in function

```python
## Mathematical
abs(x) # absolute value
max(x) # largest value (input string, list, set, tuple, ...)
min(x) # smallest value
round(x, 3) # rounding
sum(x) # sum all values

## Casting
bool(x) # to Boolean
complex(x) # to complex number
float(x) # to floating point
int(x) # to integer
str(x) # to string

## Useful functions
all(x) # returns True if all elements are True
any(x) # returns True if any element is True
range(1, 5, 2) # generates a range of values
```

### Warmup: Fairness in seven societies

Blake *et al.* ([Nature 2015](https://www.nature.com/articles/nature15703)) studied how the sense of fairness develops in different cultures. They conducted experiments to test whether and when children became adverse to disadvantageous inequity (peer receives more than self) and advantageous inequity (self receives more than a peer). Their data support the claim that disadvantageous inequity aversion emerged across all populations by middle childhood, while advantageous inequity aversion is more variable.

Experimental design:

<img src="https://media.nature.com/lw926/nature-assets/nature/journal/v528/n7581/images/nature15703-f1.jpg" alt="image from the paper" width="500">

Description:
- the "actor" on the left is presented with an allocation (of candies); they can accept/reject it acting on the levers
- the top is a situation in which the actor faces *disadvantageous inequity*; the bottom *advantageous inequity*

The data (taken from [Data Dryad](https://datadryad.org/resource/doi:10.5061/dryad.g3925)) are stored in `week2/data/Blake_et_al_Nature_2015.csv`. The csv file contains several columns:

- `condition`: the treatment (`AI` or `DI`).
- `eq.uneq`: was the distribution equal (`E`) or unequal (`U`)?
- `decision`: did the actor `accept` or `reject`?
- `country`: the country of the actor.
- `actor.id`: identifier for the actor (each actor did several trials).
- `actor.age.years`, `actor.gender`: age and gender of the actor.
- `dist`, `trial`: each of 16 trial was associated with a distribution. For `AI`, actor-recipient were either 1-1 or 4-1; for `DI` either 1-1 or 1-4; each was repeated four times.
- `value`: children were tested with `high` or `low` rewards (e.g., for Canada, Skittles vs. Goldfish crackers)


1. Using python, read the file and extract the names of the countries involved in the experiment.
2. How many `M`, `F` for each country?
3. For each country, select actors of age 10-12. Are females more likely than males to reject when the distribution is unequal and to their advantage?

