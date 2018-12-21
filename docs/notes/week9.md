## R wrapup

To wrapup the learning of R, we are going to tackle a larger project: analyze the data by Clauset *et al.* ([Science Advances 2015](http://advances.sciencemag.org/content/1/1/e1400005)) on inequality in faculty hiring. They have manually compiled a list of faculty hires at major US research institutions in three disciplines (CS, Business, History), and for each member, they have recorded the institution where they did their PhD.

### Load and clean the data

For example, for business, and assuming you're in the `sandbox`:

```r
library(tidyverse)
edges <- read_tsv("../data/Dataset 1. Business_edgelist.txt")
```

This is a list of edges:

- The first column contains the ID of the source university
- The second column contains the ID of the hiring university
- The third column specifies the rank of the hire (Assistant, Associate, Full)
- The fourth column the gender of the candidate

We rename the columns for easier programming:

```r
edges <- edges %>% rename(from = `# u`, to = "v")
```

Now we read in the information about institutions:

```r
vertices <- read_tsv("data/Dataset 2. Business_vertexlist.txt")
```

We do some cleanup of the data:

```r
vertices[vertices == "."] <- NA
vertices <- vertices %>% rename(id = `# u`, 
            usn = USN2012, 
            nrc = `NRC--`, region = Region)
vertices$usn <- as.integer(vertices$usn)
```

1. Write a function that accepts a filename for the edges, and one for the vertices, and performs the cleaning operations outlined above. The function should return a list with a `tibble` called `vertices` and another called `edges` Note however that the names of the columns vary among data sets! Can you find a way to rename them anyway?

2. Run the data cleaning on the three data sets, and store the lists in `cs`, `business` and `histry` (no `o` otherwise you rename the command `history`)

### Gender imbalance in rank

3. Produce a barplot of the count of M/F hires for each rank. In which field to we have the less gender imbalance?

```{r}
edges %>% ggplot(aes(x = gender, colour = gender, group = rank)) + geom_bar() + facet_wrap(~rank)
```

### Top feeder institutions

4. For each discipline, tally the number of times each institution is the PhD granting institution (`feeder`). Join with the vertices table to get the name of the institution. 

**Note:** Remove the row `All others` lumping together institutions in the rest of the World.

5. Write a function that plots the cumulative distribution of number of hires --- do few institutions contribute  disproportionaltely?

### Gini coefficient

You have seen that in history 4 institution provide more than 25% of the professors. To quantify the inequality you can use the Gini coefficient.

The Gini coefficient is used to measure income/wealth inequality. If `x_i` is the wealth or income of person `i`, and there are `n` people, then the Gini coefficient `G` is given by:

<a href="https://www.codecogs.com/eqnedit.php?latex=G={\frac&space;{\displaystyle&space;{\sum&space;_{i=1}^{n}\sum&space;_{j=1}^{n}\left|x_{i}-x_{j}\right|}}{\displaystyle&space;{2\sum&space;_{i=1}^{n}\sum&space;_{j=1}^{n}x_{j}}}}={\frac&space;{\displaystyle&space;{\sum&space;_{i=1}^{n}\sum&space;_{j=1}^{n}\left|x_{i}-x_{j}\right|}}{\displaystyle&space;{2n\sum&space;_{i=1}^{n}x_{i}}}}&space;$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?G={\frac&space;{\displaystyle&space;{\sum&space;_{i=1}^{n}\sum&space;_{j=1}^{n}\left|x_{i}-x_{j}\right|}}{\displaystyle&space;{2\sum&space;_{i=1}^{n}\sum&space;_{j=1}^{n}x_{j}}}}={\frac&space;{\displaystyle&space;{\sum&space;_{i=1}^{n}\sum&space;_{j=1}^{n}\left|x_{i}-x_{j}\right|}}{\displaystyle&space;{2n\sum&space;_{i=1}^{n}x_{i}}}}&space;$" title="G={\frac {\displaystyle {\sum _{i=1}^{n}\sum _{j=1}^{n}\left|x_{i}-x_{j}\right|}}{\displaystyle {2\sum _{i=1}^{n}\sum _{j=1}^{n}x_{j}}}}={\frac {\displaystyle {\sum _{i=1}^{n}\sum _{j=1}^{n}\left|x_{i}-x_{j}\right|}}{\displaystyle {2n\sum _{i=1}^{n}x_{i}}}} $" /></a>

The index ranges from 0 to approximately 1, with higher values standing for larger inequality. For example, the Gini coefficient for income inequality is 0.27 for Sweden, 0.34 for Canada, 0.41 for the US and 0.63 for South Africa.

6. Compute the Gini coefficient for the number of hires from each institution. How does it compare with economic inequality?




