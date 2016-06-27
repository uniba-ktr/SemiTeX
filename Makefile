# Copyright 2016, Marcel Großmann <marcel.grossmann@uni-bamberg.de>
objects = seminar.pdf

.PHONY: all clean

# Builds and cleans latex crap
all: $(objects) cleanTemp

$(objects): %.pdf :%.tex
	latexmk -pdf -pdflatex="pdflatex -synctex=1" -use-make $<

cleanTemp:
	latexmk -c
	rm -f *.bbl *.nlo *.nls

clean: cleanTemp
	latexmk -CA
	rm -f *.synctex.gz
