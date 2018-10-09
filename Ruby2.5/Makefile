FILE := Ruby2_5

.PHONY : default TANGLE WEAVE TEXI PDF HTML
default : WEAVE TEXI PDF HTML

TANGLE : tangle
tangle : $(FILE).twjr
	jrtangle $(FILE).twjr

WEAVE : weave
weave : TEXI
TEXI  : texi
texi  : $(FILE).texi

$(FILE).texi : $(FILE).twjr
	jrweave $(FILE).twjr > $(FILE).texi

PDF : pdf
pdf : $(FILE).pdf
$(FILE).pdf : $(FILE).texi
	pdftexi2dvi $(FILE).texi
	make distclean
	
HTML : html
html : $(FILE)/
$(FILE)/ : $(FILE).texi
	makeinfo --html $(FILE).texi

.PHONY : clean distclean worldclean
clean :
	rm -f *~ \#*\#

distclean : clean
	rm -f *.{aux,log,toc,cp,cps}

worldclean : distclean
	rm -f $(FILE).{texi,info,pdf}
	rm -fr $(FILE)/

