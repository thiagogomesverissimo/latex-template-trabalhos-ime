FILE=main

.PHONY: fast clean

fast:
	jupyter nbconvert --to markdown --output-dir='.' notebooks/notebook.ipynb
	pandoc notebook.md --listings --from markdown --to latex --output notebook.tex
	
	pdflatex -interaction=nonstopmode -halt-on-error $(FILE).tex 
	pdflatex -interaction=nonstopmode -halt-on-error $(FILE).tex
	bibtex $(FILE).aux
	pdflatex -interaction=nonstopmode -halt-on-error $(FILE).tex
	pdflatex -interaction=nonstopmode -halt-on-error $(FILE).tex

	make clean
	
clean:
	rm -rf *.aux *.bbl *.toc *.out *.log *.nls *.nlo *.lof *.lot *.blg *.ilg *.synctex.gz
	rm -rf */*.aux */*.bbl */*.toc */*.out */*.log */*.nls */*.nlo */*.lof */*.lot */*.blg */*.ilg */*.synctex.gz
	rm -rf *~ */*~
	rm notebook.md notebook.tex