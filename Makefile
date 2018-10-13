# MAKEFILE FILE CHUNKS
######################

# VARIABLE DEFINITIONS
######################
FILE := Ruby2_5
SHELL := /bin/bash


# DEFAULT RULE
##############
.PHONY : default TWJR TANGLE WEAVE TEXI PDF HTML
.PHONY : twjr tangle weave texi pdf html
default : PDF HTML


# TWJR RULES
############
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

PDF : pdf
pdf : $(FILE).pdf
$(FILE).pdf : $(FILE).texi
	pdftexi2dvi $(FILE).texi
	make distclean
	
HTML : html
html : $(FILE)/
$(FILE)/ : $(FILE).texi
	makeinfo --html $(FILE).texi


# apiutil.awk
#############
.PHONY : apiutil
apiutil : 
	bin/apiutil.awk Ruby2_5.twjr

# UTILITY TARGETS
#################

# CLEAN RULES
#############
.PHONY : clean distclean veryclean worldclean
clean :
	rm -f *~ \#*\#

distclean : clean
	rm -f *.{aux,log,toc,cp,cps,pg,pgs,bak,new}

veryclean : distclean
	for file in *; do [[ $$file =~ $(FILE)|Makefile ]] && : || rm -vrf $$file ; done;

worldclean : veryclean
	rm -fr $(FILE).{texi,info*,pdf} $(FILE)/


