
out/:
	@mkdir out

out/kth: | out
	@mkdir out/kth

out/calpoly: | out
	@mkdir out/calpoly

# As to not clash with directories
thesis_kth: | out/kth
	-latexmk -pdf -f -jobname=out/kth/kth -interaction=nonstopmode kth.tex
	mv out/kth/kth.pdf .

thesis_calpoly: | out/calpoly
	-latexmk -pdf -jobname=out/calpoly/calpoly -interaction=nonstopmode calpoly.tex
	mv out/calpoly/calpoly.pdf .