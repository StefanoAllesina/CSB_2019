#!/usr/bin/python

import re # regular expressions
import csv # manipulate csv files
import os # interface with operating system
from bs4 import BeautifulSoup # HTML parser
import sys # command line arguments

def process_file(fname):
    # this shows how simple it is to parse html (xml, json, etc.) files
    # by using the appropriate module
    print('processing', fname)
    with open(fname, 'rb') as f:
            html = f.read().decode('UTF8')
    soup = BeautifulSoup(html, 'html.parser')
    results = []
    papers = soup.findAll("div", {"class": "highwire-article-citation highwire-citation-type-highwire-article tooltip-enable"})
    for paper in papers:
        title = paper.findAll("span", {"class": "highwire-cite-title"})[0]
        title = title.text.strip()
        last_names = paper.findAll("span", {"class": "nlm-surname"})
        last_names = [n.text.strip() for n in last_names]
        num_authors = len(last_names)
        tmp = paper.findAll("span", {"class": "highwire-cite-title"})[0]
        dateurl = tmp.findAll('a')[0].get('href')
        date, paperid = re.findall(r'/content/early/(\d{4}/\d+/\d+)/(\d+)', dateurl)[0]
        results.append([str(paperid), str(date), str(num_authors), str(title)])
    return results

def process_all(my_category):
    # open csv file...
    with open('bioRXiv.csv', 'w') as fo:
       writer = csv.writer(fo)
       # and write header
       writer.writerow(['category', 'paperid', 'date', 'num_authors', 'title'])
       # process each file
       all_files = os.listdir('data/' + my_category)
       for f in all_files:
           res = process_file('data/' + my_category + '/' + f)
           for r in res:
               writer.writerow([my_category] + r)

# If run from command line, launch category 
# stored in first argument
if __name__ == "__main__":
   process_all(sys.argv[1])

