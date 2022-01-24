# Thesis
Repository for my M.Sc. thesis document, including templates for both KTH and CalPoly.

## Build
Build the PDFs using `make`
- `make kth` to create the thesis using the KTH template
- `make calpoly` to create the thesis using the CalPoly template

The command will build using `latexmk` and the finished PDF should end up in the root directory.

## Structure
The different institute templates are found under `templates/`. They simply use `\input` to include the actual content of the thesis, each chapter is found under `chapters/`.