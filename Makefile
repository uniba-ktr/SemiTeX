# Copyright 2016, Marcel Großmann <marcel.grossmann@uni-bamberg.de>
# Adjust your base GIT directory relatively to Makefile
base = .
# Internal Variables - Touch & Perish
main = seminar
styles= gitinfo2.sty gitexinfo.sty
bibtexstyles = IEEEtran.bst
classes = IEEEtran.cls
hooks = post-checkout post-commit post-merge
# Folder to clone TeXMeta to, relatively to $base
meta = $(base)/meta
# TeXMeta location
metaurl = "https://github.com/uniba-ktr/TeXMeta.git"
# Git hooks
gitinfohook = $(meta)/style/gitinfo2-hook.txt
githooks = $(base)/.git/hooks
dockerabsvol = $(shell git rev-parse --show-toplevel)
dockerincontainer = $(shell dirname $(shell git ls-tree --full-name --name-only HEAD Makefile))

.PHONY: init clean docker

.DEFAULT_GOAL := $(main)

# Call make prepare only once after checkout
prepare: initializegit gitmodules $(hooks)
	sed -i 's#\\newcommand\\meta.*#\\newcommand\\meta{${meta}}#g' $(main).tex
	ln -fs $(base)/.git/gitHeadInfo.gin gitHeadLocal.gin
	git add --all
	git commit -m "Initialized Git Foo"

# Call make init
init: $(styles) $(bibtexstyles) $(classes)
	mkdir -p graphic code images content
	cd $(meta) && git pull origin master

# Call make [seminar]
$(main): $(main).tex
	latexmk -pdf -pdflatex="pdflatex -shell-escape -synctex=1 -interaction=nonstopmode" -use-make $<
	latexmk -c

# Call make clean
clean:
	latexmk -c
	rm -f *.synctex.gz *.bbl *.nlo *.nls *.nav *.snm

# Call make docker
docker:
	@docker run -it --rm -v $(dockerabsvol)/:/src/ -w /src unibaktr/dock-tex:jessie /bin/sh -c "cd $(dockerincontainer) && make && make clean"

# Internal Targets

initializegit:
	rm -rf .git .gitmodules
	cd $(base) &&	git init

gitmodules:
	test -d $(meta) || git submodule add $(metaurl) $(meta)
	git submodule update --init

$(styles): %.sty : $(meta)/style/%.sty
	cp $^ $@

$(bibtexstyles): %.bst : $(meta)/style/%.bst
	cp $^ $@

$(classes): %.cls : $(meta)/style/%.cls
	cp $^ $@

$(hooks):
	cp $(gitinfohook) $(githooks)/$@
	chmod u+x $(githooks)/$@
