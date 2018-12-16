## Summary of Chapter 1

- The "Swiss Army Knife" of programmers
- Take a peek at the data; Perform simple data manipulations; Automation; Glue
- Hundreds of small programs, each carrying out a specific task
- "Worse is better"
- Connect input and output using "pipe" `|` and redirection `>` (or `>>`)

### Navigating the directory system

- To find out where you are: `pwd` (print working directory)
- Move one up with `cd ..`; move down `cd wheretogo`
- Relative vs. absolute path: `cd /home/sallesina/CSB/unix` vs. `cd ../CSB/unix`
- Home directory `~`
- Go back to where you were last `cd -`
- List files `ls`
- Command modifiers `ls -l` (long format)

### Working with files and directories

- Copy `cp myfile newloc`
- Move (or rename) `mv myfile newloc`
- Update file `touch myfile` (if file does not exist, it will be created)
- Remove file `rm myfile`
- Remove (empty) directory `rmdir mydir`
- Remove (non-empty) directory `rm -r mydir` **BEWARE!**
- First few lines `head myfile`
- Last few lines `tail -n3 myfile` (three lines)
- All but a few `tail -n+2 myfile` (all but first)
- Concactenate file(s) (or print to screen) `cat myfile1 myfile2`
- Count lines/words/bytes `wc myfile` (only lines `wc -l myfile`)
- Sort alphabetically lines `sort myfile`
- Sort numerically `sort -n myfile`
- Unique lines `uniq myfile` (with number of occurrences `uniq -c myfile`) **The file needs to be sorted!**

## Pipes and redirection

- Send text to a file `echo "my first line" > myfile.txt`
- Append text to a file `echo "my second line" >> myfile.txt`
- Pipe operator: take whatever is on the left, and use as input for the command on the right.
- `ls -l | wc -l` (count files and sub-directories in current directory)
- `sort myfile | uniq > no_duplicates.txt` sort and remove duplicates




### Warmup: Nobel data

The file `data/nobel.csv` contains the names and motivations for all the Nobel prizes awarded so far.

- Find the number of winners for each Nobel prize (`chemistry`, `economics`, `literature`, `medicine`, `peace`, `physics`). 

<details><summary>Solution</summary>

`tail -n+2 nobel.csv | cut -f3 -d, | sort | uniq -c`

</details>

- Find the winners of multiple Nobel prizes

<details><summary>Solution</summary>

`cut nobel.csv -f5-6 -d, | sort | uniq -c | sort -n -r | head -n10`

</details>


- Find the most common `surname`s among the winners

<details><summary>Solution</summary>

`cut nobel.csv -f6 -d, | sort | uniq -c | sort -n -r | head -n10`

</details>
