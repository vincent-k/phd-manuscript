BASE=thesis
FINAL=manuscript_pellegrino_laurent
OS=$(shell uname)
READER=evince

ifeq ($(OS),Darwin)
	READER=open
endif

all:  
	pdflatex $(BASE).tex
	biber $(BASE)
	pdflatex $(BASE).tex
	biber $(BASE)
	pdflatex $(BASE).tex
	mv $(BASE).pdf $(FINAL).pdf

bib: $(BASE).bib
	biber $(BASE) 

tex:	
	pdflatex $(BASE).tex

view: all
	$(READER) $(FINAL).pdf &

clean:
	find . -name "*.aux" -exec rm {} \;
	rm -f *~ *.aux *.bbl *.bcf *.blg *.lof *.log *.lol *.lot *.dvi *.maf \
	      *.mtc* *.out *.ps *.run.xml *.synctex.gz *.toc *.tdo

veryclean: clean
	rm -f $(FINAL).pdf
	find . -name "*eps-converted-to.pdf" -exec rm {} \;
