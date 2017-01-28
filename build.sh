#!/bin/sh

pdflatex -shell-escape -interaction=nonstopmode "Barbu Paul - Gheorghe.tex"
bibtex "Barbu Paul - Gheorghe"
pdflatex -shell-escape -interaction=nonstopmode "Barbu Paul - Gheorghe.tex"
pdflatex -shell-escape -interaction=nonstopmode "Barbu Paul - Gheorghe.tex"
 
