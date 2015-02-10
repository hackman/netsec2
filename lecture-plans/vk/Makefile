
NAMES=crypto

TARGETS=$(patsubst %.pandoc,%.pdf,$(wildcard *.pandoc)) $(patsubst %.pandoc,%-blog.txt,$(wildcard *.pandoc))

IMGS=

all: $(TARGETS)

%.pdf: %.pandoc beamer.my beamercolorthemekrok.sty $(IMGS)
	pandoc --slide-level 3 -t beamer $< --template beamer.my -V theme:Warsaw -V fonttheme:structurebold -V colortheme:krok -o $@

%-blog.txt: %.pandoc
	php etxt.php $< > $@
clean:
	rm -f $(TARGETS)

push:
	git push origin master
