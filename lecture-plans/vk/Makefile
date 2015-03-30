
TARGETS=$(patsubst %.pandoc,%.pdf,$(wildcard *.pandoc)) $(patsubst %.pandoc,%-blog.txt,$(wildcard *.pandoc))

all: depend $(TARGETS)

depend: .depend

.depend: $(wildcard *.pandoc) makedep.sh
	rm -f .depend
	./makedep.sh > .depend

-include .depend

%.pdf: %.pandoc beamer.my beamercolorthemekrok.sty
	pandoc --slide-level 3 -t beamer $< --template beamer.my -V theme:Warsaw -V fonttheme:structurebold -V colortheme:krok -o $@

%.png: img/%.png
	./mkimg.sh $@

%-blog.txt: %.pandoc
	php etxt.php $< > $@
clean:
	rm -f $(TARGETS) *.png .depend

push:
	git push origin master
