#!/bin/bash

cd Python/

jupyter nbconvert --to=latex --LatexExporter.template_file=./EpiExpOutline.tplx TagRemovePreprocessor.remove_cell_tags='{"remove_cell"}' EpiExpOutline.ipynb

pdflatex EpiExpOutline.tex

bibtex EpiExpOutline.aux
pdflatex EpiExpOutline.tex
pdflatex EpiExpOutline.tex

rm *.bbl *.aux *.blg *.log *.out *Notes.bib #*.tex

cd ..
cd .. 
