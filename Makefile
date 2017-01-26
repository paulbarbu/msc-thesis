.PHONY: clean
build:
	pdflatex -shell-escape -interaction=nonstopmode "Barbu Paul - Gheorghe.tex"
	bibtex "Barbu Paul - Gheorghe"
	pdflatex -shell-escape -interaction=nonstopmode "Barbu Paul - Gheorghe.tex"
	pdflatex -shell-escape -interaction=nonstopmode "Barbu Paul - Gheorghe.tex"
clean:
	rm -rf *.log *.synctex.gz *.toc *.aux *bbl *blg *.bak *.out _minted-Barbu_Paul_-_Gheorghe
	rm -rf "Barbu Paul - Gheorghe.pdf"
