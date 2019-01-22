library(tidyverse)
# read the data
dt <- read_csv("https://tinyurl.com/ycc4ndkd") %>% select(-state)

# 1. Find the number of distinct names for boys and girls.

ex1 <- dt %>% select(sex, name) %>% 
  distinct() %>% group_by(sex) %>% tally()
print(ex1)

# 2. Find the name/year combination with highest `count` for each `sex`.

ex2 <- dt %>% group_by(sex) %>% top_n(1, count)
print(ex2)

# 3. Plot the number of distinct names for `M` or `F` in time.

ex3 <- dt %>% ggplot() + 
  aes(x = year, fill = sex) + 
  geom_bar(position = "dodge")
show(ex3)

# 4. As you can see, the diversity of names has been growing. 
# Plot the number of "effective" names in time. 
# First, compute Shannon's entropy for each year/sex. 
# Then exponentiate to obtain the number of names that 
# would produce the same entropy while having equal frequency. 

ent <- dt %>% group_by(sex, year) %>% 
  mutate(p = count / sum(count)) %>% 
  summarise(entropy = -sum(p * log(p)))

ex4 <- ent %>% ggplot() + 
  aes(x = year, colour = sex, y = exp(entropy)) + 
  geom_point() + geom_line() + 
  ylab("Number of effective names")
show(ex4)

# 5. Plot the difference in number of distinct names between `F` and `M` in time.

diff_unique_names <- dt %>% 
  group_by(sex, year) %>% 
  tally() %>% 
  spread(sex, n) %>% 
  mutate(difference = `F` - `M`)

ex5 <- ggplot(diff_unique_names) + 
  aes(x = year, y = difference) + 
  geom_point() + geom_line()
show(ex5)

# 6. Find the frequency with wich each name ends with a certain letter. 
# Show a barplot for the probability that a name (for boys or girls) 
# ends with a given letter. Use years 1950, 1975, 2000 and 2015.

last_letter <- dt %>% mutate(last_letter = stringr::str_sub(name, -1)) %>% 
  group_by(year, sex, last_letter) %>% 
  summarise(tot = sum(count)) 
last_letter <- last_letter %>% 
  group_by(year, sex) %>% 
  mutate(prob = tot / sum(tot))

ex6 <- ggplot(data = last_letter %>% 
                filter(year %in% c(1950, 1975, 2000, 2015))) + 
  aes(x = last_letter, y = prob) + 
  geom_col() + facet_grid(sex ~ year)
show(ex6)

# 7. Plot the popularity of each letter for ending names in time, for boys and girls. 
# Which letters are growing, which declining?
  
ex7 <- ggplot(data = last_letter) + 
  aes(x = year, y = prob, label = last_letter, colour = last_letter) + 
  geom_text() + geom_line() + facet_wrap(~sex) + scale_y_log10()
show(ex7)

# find 10 names that were popular in 2015 but were not present in 1950
dt2015 <- dt %>% filter(year == 2015) %>% 
  group_by(sex, name) %>% 
  summarise(tot = sum(count)) %>% 
  arrange(desc(tot))
dt1950 <- dt %>% filter(year == 1950) %>% 
  group_by(sex, name) %>% 
  summarise(tot = sum(count)) %>% 
  arrange(desc(tot))
in_2015_not_1950 <- dt2015 %>% anti_join(dt1950 %>% select(name, sex))
print(in_2015_not_1950 %>% group_by(sex) %>% top_n(10, tot))

