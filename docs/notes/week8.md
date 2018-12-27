## Summary of Chapter 9

- The `tidyverse` provides a set of packages for the organization, manipulation and visualization of large data sets.
- `tidyverse` "an opinionated collection of R packages designed for data science. All packages share an underlying design philosophy, grammar, and data structures."
- Based on the pipeline operator `%>%` (type `Ctrl + Shift + M`): write code that is easy to read and debug.

You can load all the essential packages in the bundle running

```r
library(tidyverse)
```

### Data: top 500 albums according to "Rolling Stone"

```r
# This is a better routine to load large data sets
# part of package readr
dt <- read_csv("https://goo.gl/W4SSdj", 
               locale = locale(encoding = "latin1"))
```

### How to take a look around

```r
head(dt) # first few rows
tail(dt) # last few rows
glimpse(dt) # structure
View(dt) # spreadsheet
```

### Pipelines

Example: number of top 500 rock albums by *The Beatles*:

```r
# lots of dollar signs
nrow(dt[dt$Artist == "The Beatles" & dt$Genre == "Rock",])
```

Decade with the highest number of rock top 500 albums

```r
# the nested code quickly becomes difficult to read
as.integer(names(sort(table(dt$Year[dt$Genre == "Rock"] %/% 10), 
                      decreasing = TRUE)[1])) * 10
```

Solution: pipelines `%>%` (`Ctrl + Shift + M`) allow you to "unroll" your code:

```r
# Easy to read code. No dollar signs. Easy to add/remove pieces
dt %>% 
  filter(Genre == "Rock", Artist == "The Beatles") %>% 
  tally()
```

```r
dt %>% 
  filter(Genre == "Rock") %>% 
  mutate(decade = (Year %/% 10) * 10) %>% 
  group_by(decade) %>% summarise(tot_albums = n()) %>% 
  arrange(desc(tot_albums))
```

### Subsetting rows

```r
# using logical criteria
dt %>% 
  filter(Artist == "The Beatles", Year > 1968)
# at random
dt %>% 
  sample_frac(0.01)
dt %>% 
  sample_n(3)
# by position
dt %>% 
  slice(1:3)
# ordering by a col
dt %>% 
  top_n(2, Year)
dt %>% 
  top_n(1, desc(Artist))
```

### Subsetting cols

```r
dt %>% 
  select(Artist) %>% 
  head(3)
# by name (regex etc)
dt %>% 
  select(starts_with("A")) %>% 
  head(2)
# distinct rows
dt %>% select(Artist) %>% distinct()
```

### Ordering 

```r
dt %>% arrange(Artist) %>% head(3)
dt %>% arrange(desc(Artist), Year) %>% head(3)
```

### Adding new columns

```r
# as a function of current cols
dt %>% mutate(decade = (Year %/% 10) * 10) %>% head(3)
# ex novo
dt %>% add_column(I_have_it = NA)
# renaming col
dt %>% rename(yr = Year)
```

### Summaries

```r
# distribution of length band name
dt %>% 
  select(Artist) %>% 
  mutate(namelen = nchar(Artist)) %>% 
  summarise(min = min(namelen),
            mean = mean(namelen), 
            median = median(namelen),
            stdev = sd(namelen),
            max = max(namelen))
```

### Groups
The true strength of this approach is the possibility of grouping observations, and perform operations based on these groups:

```r
# Number of top albums by genre
dt %>% group_by(Genre) %>% tally() %>% arrange(desc(n))

# Order of top albums by band
dt %>% 
  select(Artist, Year) %>% 
  arrange(Year) %>% 
  add_column(tmp = 1) %>% 
  group_by(Artist) %>% 
  mutate(num = cumsum(tmp)) %>% 
  filter(Artist %in% c("The Beatles", "Bob Dylan"))

# Number of albums by Genre/Year
dt %>% group_by(Year, Genre) %>% tally()
```

### From messy tables to tidy and back

Goal: produce a heatmap with rows -> Artists, cols -> Years and color each configuration with a top album

```r
for_heatmap <- dt %>% 
  select(Artist, Year) %>% 
  distinct() %>% 
  add_column(tmp = 1) %>% 
  spread(Year, tmp, fill = 0) %>% 
  gather(Year, Top, -Artist)
```

### Plotting

```r
for_heatmap %>% 
  ggplot()+ aes(x = Year, y = Artist, fill = as.factor(Top)) + geom_tile() + scale_fill_manual(values = c("white", "black"))
```
