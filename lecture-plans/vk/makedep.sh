#!/bin/bash

for i in *.pandoc; do
	pdfn=`echo $i|sed s/\.pandoc$/.pdf/`
	echo $pdfn: `grep '^!' "$i"|cut -d \( -f 2|cut -d \) -f 1|sort|uniq `
done
