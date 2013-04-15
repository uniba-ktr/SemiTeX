SemiTeX
=======

A LaTeX template for the seminar submissions

Setup
-----

Edit the <code>\newcommand{\lang}{ngerman}</code> command to setup the language You write your submission in. Possible options are 
* <code>ngerman</code> and
* <code>english</code>.

Furthermore, edit the <code>config/metainfo.tex</code> file to include
* your name and 
* the submission date.

Compiling the Source Code
-------------------------

Use `pdflatex`, `makeindex` and `bibtex` to generate a readable document.
If You use texmaker, you can include the following command to automatically compile the sources: 
<code>pdflatex -synctex=1 -interaction=nonstopmode %.tex | bibtex % | 
makeindex %.nlo -s nomencl.ist -o %.nls | pdflatex -synctex=1 -interaction=nonstopmode %.tex 
| pdflatex -synctex=1 -interaction=nonstopmode %.tex</code>

