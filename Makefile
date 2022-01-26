
out/:
	@mkdir out

out/kth: | out
	@mkdir out/kth

out/calpoly: | out
	@mkdir out/calpoly

# As to not clash with directories
kth: | out/kth
	-latexmk -pdf -f -jobname=out/kth/kth -interaction=nonstopmode kth.tex
	mv out/kth/kth.pdf .

calpoly: | out/calpoly
	-latexmk -pdf -jobname=out/calpoly/calpoly -interaction=nonstopmode calpoly.tex
	mv out/calpoly/calpoly.pdf .

all: kth calpoly

clear:
	@rm -rf out/ kth.pdf calpoly.pdf
