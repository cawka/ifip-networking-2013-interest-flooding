################################################################
# Usage:
#	pdf ==> create pdf file
#	ps  ==> create ps file
#	clean ==> clean all files generated
################################################################

latexfile=paper
TEX=pdflatex
BIBTEX=bibtex

all: $(latexfile).pdf

$(latexfile).pdf: *.tex *.bib algos/*.tex figures/*.pdf
	$(TEX) $(latexfile) && $(BIBTEX) $(latexfile) && $(TEX) $(latexfile) && $(TEX) $(latexfile)

clean:
	rm -f $(latexfile).dvi $(latexfile).pdf $(latexfile).ps $(latexfile).aux $(latexfile).log $(latexfile).bbl $(latexfile).blg $(latexfile)_diff.* $(latexfile)_old.tex $(latexfile)_new.tex

view: $(latexfile).pdf
	open $(latexfile).pdf &
