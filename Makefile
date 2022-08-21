
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
	notify Compiled KTH

calpoly: | out/calpoly
	-latexmk -pdf -jobname=out/calpoly/calpoly -interaction=nonstopmode calpoly.tex
	mv out/calpoly/calpoly.pdf .
	notify Compiled KTH

all: kth calpoly

txt:
	pandoc -f latex -i kth.tex -t markdown+hard_line_breaks -o kth.txt
	pandoc -f latex -i calpoly.tex -t markdown+hard_line_breaks -o calpoly.txt

clean:
	@rm -rf out/ kth.pdf calpoly.pdf
