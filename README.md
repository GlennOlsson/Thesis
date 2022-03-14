# Thesis
Repository for my M.Sc. thesis document, including templates for both KTH and CalPoly.

## Build
Build the PDFs using `make`
- `make kth` to create the thesis using the KTH template
- `make calpoly` to create the thesis using the CalPoly template

The command will build using `latexmk` and the finished PDF should end up in the root directory.

The thesis has perviously been built on MacOS Monterey with `GNU Make 3.81` and `Latexmk, John Collins, 20 November 2021. Version 4.76`

### Overleaf
This project can also be compiled online using Overleaf (as of TeX Live Version 2021). Set the compiler as "*pdfLaTeX*" and the "*main document*" to be either `kth.tex` or `calpoly.tex` depending on which one you want to compile. To switch compiled file, you might have to clear the cache of files (as it is not possible to change the jobname on Overleaf and the output files will clash). This can be done under `logs -> clear cached files`.

## Structure
The different institute templates are found under `templates/`. They simply use `\input` to include the actual content of the thesis, each chapter is found under `chapters/`. 

The root file of each school is in the root directory (`kth.tex` and `calpoly.tex`), so all paths to images, files etc. must be relative to the root of the repo.  

## Pre-hook
A script named [make_decision.zsh](make_decision.zsh) exists to check if the current built PDFs are up to date with the written text. This can be used in a pre-commit hook on git by adding this to the local `.git/hooks/pre-commit` file:
```sh
#!/bin/sh
#
# Script to check that the PDFs are up-to-date, otherwise fail commit

zsh make_decision.zsh
if [[ "$?" != "0" ]]; then
		cat <<\EOF
Can't commit, must first rebuild PDFs
EOF
	exit 1
fi 
```