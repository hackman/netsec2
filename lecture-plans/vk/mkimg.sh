#!/bin/bash

img=$1

geom=`identify -quiet -format '%G' img/$img`
width=`echo $geom |cut -d x -f 1`
height=`echo $geom |cut -d x -f 2`

wantedwidth=`echo -e "scale=0\n$height"'*'"1.4"|bc|cut -d . -f 1`

if [ $width -gt $wantedwidth ]; then
	cp "img/$img" "$img"
else
	convert "img/$img" -gravity center -extent ${wantedwidth}x${height} "$img"
fi
