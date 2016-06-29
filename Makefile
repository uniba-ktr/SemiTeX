# Copyright 2016, Marcel Großmann <marcel.grossmann@uni-bamberg.de>
objects = seminar.pdf
hooks = post-checkout post-commit post-merge
githooks = .git/hooks

.PHONY: all init clean cleanTemp git docker

.DEFAULT_GOAL := all

all: $(objects) cleanTemp

init: git
	mkdir -p graphic code images content

$(objects): %.pdf :%.tex
	latexmk -pdf -pdflatex="pdflatex -shell-escape -synctex=1 -interaction=nonstopmode" -use-make $<

cleanTemp:
	latexmk -c
	rm -f *.bbl *.nlo *.nls

clean: cleanTemp
	latexmk -CA
	rm -f *.synctex.gz

git: $(hooks)

$(hooks):
	cp gitinfo2-hook.txt $(githooks)/$@
	chmod u+x $(githooks)/$@

docker:
	docker-compose run builder
