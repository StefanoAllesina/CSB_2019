### Warmup: Nobel data

The file `data/nobel.csv` contains the names and motivations for all the Nobel prizes awarded so far.

- Find the number of winners for each Nobel prize (`chemistry`, `economics`, `literature`, `medicine`, `peace`, `physics`). 

<details><summary>Solution</summary>
<p>

```
tail -n+2 nobel.csv | cut -f3 -d, | sort | uniq -c
```

</p>
</details>

- Find the winners of multiple Nobel prizes

<details><summary>Solution</summary>
<p>

```
cut nobel.csv -f5-6 -d, | sort | uniq -c | sort -n -r | head -n10
```

</p>
</details>


- Find the most common `surname`s among the winners

<details><summary>Solution</summary>
<p>

```
cut nobel.csv -f6 -d, | sort | uniq -c | sort -n -r | head -n10
```

</p>
</details>
