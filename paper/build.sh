#!/bin/sh

mkdir -p submitted
mkdir -p biorxiv

cd src

## Submitted version
pdflatex  \\nonstopmode\\input main.tex
bibtex --min-crossref=100 main
bibtex --min-crossref=100 main
pdflatex  \\nonstopmode\\input main.tex

mv main.aux main.log main.out main.pdf ../submitted/

## Biorxiv version

sed 's/oup-authoring-template/biorxiv/g' main.tex \
    | sed 's/,contemporary,large/,modern,large/g' \
    | sed 's/\\street[[:space:]{}A-Za-z0-9]*[,][[:space:]]//g' \
    | sed 's/\\postcode[[:space:]{}A-Za-z0-9]*[,][[:space:]]//g' > biorxiv.tex
pdflatex  \\nonstopmode\\input biorxiv.tex
bibtex --min-crossref=100 biorxiv
bibtex --min-crossref=100 biorxiv
pdflatex  \\nonstopmode\\input biorxiv.tex

mv biorxiv.aux biorxiv.log biorxiv.out biorxiv.pdf biorxiv.tex ../biorxiv/

cd ../
