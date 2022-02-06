## this script takes a latex file as the input,
##  replace all the \cite{xxx} with \href{link_to_xxx}{\cite{xxx}}
##    so that clcking the title will direct the reader to the link to the cited paper.
###    the link for a particular xxx is saved in a seperate csv file.

import os
import pandas as pd
import re

## load the bib database with handles, links, etc
cwd = os.getcwd()

## file names

bib_csv = 'reference-links.csv'
latex_file = 'latex_example2.tex'

## prepare the paths of documents

bib_csv = os.path.join(cwd,bib_csv)
bib_df = pd.read_csv(bib_csv)

## load the latex file
latex_file = os.path.join(cwd,latex_file)

## functions

def find_link(handle,bib_df):
    """Returns the link to a particular citation by searching the handle in the csv file."""
    the_link = bib_df['link'][bib_df['ID'] ==handle].iloc[0]
    return the_link

def add_href(cite_text,link):
    """Returns the latex text with `\href{link}{' in front and '}' after the cite tex \cite{xxx}"""
    text_with_link_bf = '\href{'+str(link)+'}{'
    text_with_link_af = '}'
    return text_with_link_bf,text_with_link_af


def drop_href(handle,text):
    #whole_thing = '\cite{'+handle+'}'
    lookfor = r"\\href\{(.*?)\}\{\\cite\{"+handle+r"\}\}"
    #lookfor = r"\\href\{[a-zA-Z]+\}\{"+"\\cite\{"+handle+"\}\}"
    #replace = "\\cite{"+handle+"}"
    replace  = r"\\cite{"+handle+"}"
    text =re.sub(lookfor, replace,text)
    return text


def replace_cite(handle,text,bib_df):
    whole_thing = '\cite{'+handle+'}'
    occurs = text.count(whole_thing)
    print(str(occurs)+' times')
    link = find_link(handle,bib_df)
    to_add_bf,to_add_af = add_href(whole_thing,link)
    from_where = 0
    for n in range(occurs):
        bf_idx = text.index(whole_thing,from_where)
        text = text[:bf_idx] + to_add_bf + text[bf_idx:]
        af_idx = bf_idx+len(whole_thing)+len(to_add_bf)
        text =text[:af_idx]+ to_add_af + text[af_idx:]
        from_where = af_idx
    return text


### do the replace_cite for each handle in the dataframe file.
  ## first search the \cite of the handle, locate it in the latex_tex
  ## second find the link from dataframe.
  ### thrid, replace the \cite with text with the link_to_xxx
  #### fourth, replace the new text in the latex text


## open the old latex file and load all texts
with open(latex_file,'r') as f:
    old_text = str(f.read())
    #print(old_tex)
    f.close()


## first delete all hrefs

## process the old texts

new_text = old_text
for i in range(len(bib_df)):
    this_handle = bib_df['ID'].iloc[i]
    new_text = drop_href(this_handle,new_text)
    new_text = replace_cite(this_handle,new_text,bib_df)
## update the file
with open(latex_file,'w') as f:
    f.write(new_text)
    f.close()
