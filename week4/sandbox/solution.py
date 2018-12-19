import re

# read all of the html in one go
with open('scopus.html', 'r') as content_file:
    content = content_file.read()

find_author = re.compile(r'title="View this author&#39;s profile"> (.*)<')
author_list = re.findall(find_author, content)

find_num_papers = re.compile(r'"View documents for this author" class="txtSmaller">\n(.*)')
paper_list = re.findall(find_num_papers, content)

find_disciplines = re.compile(r'<td class="dataCol4">\n(.*)')
discipline_list = re.findall(find_disciplines, content)

all_authors = []
for i in range(len(author_list)):
   all_authors.append([author_list[i].strip(),
                       int(paper_list[i]),
                       discipline_list[i].strip()])


