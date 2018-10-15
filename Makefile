# MAKEFILE FILE CHUNKS
######################

# VARIABLE DEFINITIONS
######################
FILE := Ruby2_5
SHELL := /bin/bash


# DEFAULT Target
################
.PHONY : default TWJR TANGLE WEAVE TEXI INFO PDF HTML
.PHONY : twjr tangle weave texi info pdf html
default : INFO PDF HTML


# TWJR TARGETS
##############
TWJR : twjr
twjr : tangle weave

TANGLE : tangle
tangle : $(FILE).twjr
	jrtangle $(FILE).twjr

WEAVE : weave
weave : TEXI
TEXI  : texi
texi  : $(FILE).texi
$(FILE).texi : $(FILE).twjr
	jrweave $(FILE).twjr > $(FILE).texi

INFO : info
info : $(FILE).info
$(FILE).info : $(FILE).texi
	makeinfo $(FILE).texi
openinfo : INFO
	emacs $(FILE).info

PDF : pdf
pdf : $(FILE).pdf
$(FILE).pdf : $(FILE).texi
	pdftexi2dvi --build=tidy --build-dir=build --quiet $(FILE).texi
openpdf : PDF
	open $(FILE).pdf

HTML : html
html : $(FILE)/index.html
$(FILE)/index.html : $(FILE).texi
	makeinfo --html $(FILE).texi
openhtml : HTML
	open $(FILE)/index.html


# apiutil.awk
#############
.PHONY : apiutil
apiutil : 
	bin/apiutil.awk Ruby2_5.twjr

# UTILITY TARGETS
#################

# CLEAN TARGETS
###############
.PHONY : clean veryclean dirclean distclean worldclean
clean :
	rm -vf *~ .*~ \#*\#

# clean tex detritus
texclean : clean
	rm -vf *.{dvi,aux,log,toc,cp,cps,pg,pgs}

# remove all dirs except HTML; remove *.{rb,sh} files from toplevel
dirclean : clean
	for file in *; do [ -d $$file ] && [ $${file##$(FILE)*} ] && rm -vfr $$file; done;\
	rm -vf *.{rb,sh}

# remove everything except .twjr, .texi, and Makefile
distclean : dirclean
	for file in *; do [[ $$file =~ twjr|texi|Makefile ]] && : || rm -vrf $$file ; done;

worldclean : distclean
	rm -fr $(FILE).{texi,info*,pdf} $(FILE)/


