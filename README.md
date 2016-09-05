# SemiTeX

A LaTeX template for the seminar submissions

## Setup

### Easy Initialization with GNU make

In the `Makefile` you may adjust the `base` variable to setup your git base directory relatively to the cloned directory.


First of all, run `make` to initialize the repository and execute the initial build.
Thereafter, only run `make` in the cloned directory to recreate your `pdf` file.

### Without make

 1. Remove the `.git` folder and the `.gitmodules` file to be able to create a new git repository
 2. Checkout all necessary submodules with `git submodule init` followed by `git submodule update`
 3. Create the directories `graphic`, `code`, `images` and `content`
 4. Copy `meta/style/gitexinfo.sty`, `meta/style/gitinfo2.sty`, `meta/style/IEEEtran.bst` and `meta/style/IEEEtran.cls` to the root of your cloned directory.
 5. For versioning of your PDF files copy `meta/style/gitinfo2-hook.txt` to `.git/hooks/post-checkout`, `.git/hooks/post-commit` and `.git/hooks/post-merge` and make these copies executable.

### Necessary Configurations

 1. Edit the `config/metainfo.tex` file to include
    * your name in the `\author{}` command
    * the submission date in `\date{}` and
    * the title in `\newcommand{\subtitle}{}`.
 2. Modify `\gittrue` to `\gitfalse` in `config/metainfo.tex` to disable git versioning.
 3. Edit the `\selectlanguage{}` command in `seminar.tex` to setup the language you write your submission in. Possible options are
    * `ngerman`
    * `english`

## Generating the PDF

Use `latexmk` to generate a readable document, or use `make all` of the `Makefile`.
If You use texmaker, set `latexmk` as your default build command

## Cleaning Up

Run `make clean` or `latexmk -C` to remove the generated PDF and all temporary LaTeX files.
