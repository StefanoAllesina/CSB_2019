## Summary of Chapter 10

- When you have much data, it is convenient to organize them in a relational database.
- You save space (better encoding of common data types).
- You can have multiple users query/modify the data at the same time.
- You have added security.
- You don't need to store the data locally.

### SQL

Most modern relational databases implement a Structured Query Language (with many dialects) allowing you to port your queries across platforms.

### Building the database

I have rearranged the data from week 9 in a format that can be imported into the database directly, and saved it into `week10/data`. Take a look at the `.csv` files:

```
head all_institutions.csv
head all_edges.csv
```

Now we're going to launch `sqlite3` and build the database one step at a time. Then, I'll show you how to build it using a script

```
$ sqlite3 # or wherever your program is
sqlite> .mode csv
sqlite> .import all_edges.csv edges
```

This command has created a table called `edges`. See that it worked:

```
sqlite> .table
edges 
sqlite> .schema
CREATE TABLE edges(
  "from_id" TEXT,
  "to_id" TEXT,
  "rank" TEXT,
  "gender" TEXT,
  "field" TEXT
);
```

Now the other table:

```
sqlite> .mode csv
sqlite> .import all_institutions.csv nodes
sqlite> .table
edges  nodes
sqlite> .schema
CREATE TABLE edges(
  "from_id" TEXT,
  "to_id" TEXT,
  "rank" TEXT,
  "gender" TEXT,
  "field" TEXT
);
CREATE TABLE nodes(
  "id" TEXT,
  "institution" TEXT,
  "region" TEXT
);
```

Save and quit:
```
sqlite> .save hires.db
# Then press Ctrl + D to quit
```

If you save your commands in a script, you can run it automatically:

```
$ rm hires.db # delete file
$ cat build_db.sql 
.mode csv
.import all_edges.csv edges
.import all_institutions.csv nodes
.table
.schema
$ sqlite3 hires.db < build_db.sql
$ ls
```

### Simple queries

```
sqlite> .mode column # nicer appearence
sqlite> .header on
sqlite> SELECT * FROM nodes LIMIT 5;
id          institution                   region    
----------  ----------------------------  ----------
1           Abilene Christian University  South     
2           All others                    Earth     
3           American University, Washing  South     
4           Arizona State University      West      
5           Auburn University             South    
```

Unique regions:

```
sqlite> SELECT DISTINCT region FROM nodes;
region    
----------
South     
Earth     
West      
Northeast 
Midwest   
Canada    
```

Sort them alphabetically
```
sqlite> SELECT DISTINCT region FROM nodes ORDER BY region;
```

Names contain "University"
```
sqlite> SELECT institution FROM nodes
   ...> WHERE institution LIKE "%University%"
   ...> LIMIT 5;   
```

### Grouping 

Count the number of hires by gender

```
sqlite> SELECT gender, COUNT(*) FROM edges GROUP BY gender;
```

Count the number of hires by rank
```
sqlite> SELECT rank, COUNT(*) FROM edges GROUP BY rank;
```

Count by gender and rank

```
sqlite> SELECT gender, rank, COUNT(*) FROM edges GROUP BY gender, rank;
```

### Views and Joining

Create a view where we specify the region of the PhD institution

```
sqlite> CREATE VIEW regionphd AS 
        SELECT region AS from_reg, from_id, to_id 
        FROM nodes INNER JOIN edges ON nodes.id = edges.from_id;
```

Now you can use the view as a normal table:

```
sqlite> .table
sqlite> SELECT * FROM regionphd LIMIT 5;
```

Now join the view with `nodes` to get the region of the hiring institution:

```
sqlite> CREATE VIEW regionmove AS 
        SELECT region AS to_reg, from_id, to_id, from_reg
        FROM nodes INNER JOIN regionphd ON nodes.id = regionphd.to_id;
```

Create a table of flows from region to region:
```
SELECT from_reg, to_reg, COUNT(*) FROM regionmove GROUP BY from_reg, to_reg;
```

### Warmup

- Build a query showing the top 10 institutions where UofC graduates end up working:

<details>
 <summary>Solution</summary>

SELECT to_id, institution, COUNT(*) as N 
FROM edges 
INNER JOIN nodes ON nodes.id = edges.to_id 
WHERE from_id == 152 
GROUP BY to_id ORDER BY N  DESC LIMIT 10;

</details>

- Build a query showing the top 10 institution  UofC faculty come from:

<details>
 <summary>Solution</summary>
 
SELECT from_id, institution, COUNT(*) as N 
FROM edges 
INNER JOIN nodes ON nodes.id = edges.from_id 
WHERE to_id == 152 
GROUP BY from_id ORDER BY N  DESC LIMIT 10;

</details>

- Find the 10 institutions with the highest proportion of female professors. Repeat with males.

<details>
 <summary>Solution</summary>

First, we create a view containing the number of faculty by gender:

CREATE VIEW prof_gender AS 
SELECT to_id, institution, gender, COUNT(*) AS N 
FROM edges INNER JOIN nodes ON nodes.id = edges.to_id 
GROUP BY to_id, gender 
ORDER BY institution, gender;

Then, a view with the total number of profs:

CREATE VIEW prof AS 
SELECT to_id, institution, COUNT(*) AS N 
FROM edges INNER JOIN nodes ON nodes.id = edges.to_id 
GROUP BY to_id
ORDER BY institution, gender;

Now a view that joins the two views and computes the proportion of female and males profs:

CREATE VIEW prop_gender AS 
SELECT prof.institution, gender, 
prof.N AS Tot, 
prof_gender.N as G, 
CAST(prof_gender.N AS REAL)/prof.N AS Proportion 
FROM prof 
LEFT JOIN prof_gender ON prof.institution  = prof_gender.institution;

Now we can build simple queries to answer the questions:

SELECT * FROM prop_gender 
WHERE gender == "F" 
ORDER BY Proportion DESC 
LIMIT 10;

SELECT * FROM prop_gender 
WHERE gender == "M" 
ORDER BY Proportion DESC 
LIMIT 10;

</details>
