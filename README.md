SemiTeX
====

A LaTeX template for the seminar submissions

Setup
===

Edit the \lang command to setup the language You write your submission in. Possible options are ngerman and english.
Furthermore, edit the config/metainfo.tex file to include your name and the submission date.

Compiling the Source Code
===

Use pdflatex, makeindex and bibtex to generate a readable document.
If You use texmaker, you can include the following command to automatically compile the sources: pdflatex -synctex=1 -interaction=nonstopmode %.tex | bibtex % | makeindex %.nlo -s nomencl.ist -o %.nls | pdflatex -synctex=1 -interaction=nonstopmode %.tex | pdflatex -synctex=1 -interaction=nonstopmode %.tex

