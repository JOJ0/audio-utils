#!/bin/bash
if [ "$1" == "dry" ]; then
  DRY="echo"
fi

for M4A in ./*m4a; do
  # this works but better let sox detect the wavformat
  #$DRY alac "$M4A" | sox -t raw -e signed-integer -c 1 -b 16 -r 44100 - -c 1 -b 16 "$(echo $M4A | sed -e s/.m4a/_mono.wav/g)";
  #
  # just spit out fileinfo -> yes alac outputs a 16b signed-int PCM wav
  #$DRY alac "$M4A" | soxi -
  #
  # sox automagically detecting file type
  echo "$M4A"
  $DRY alac "$M4A" | sox - -c 1 -b 16 "$(echo $M4A | sed -e s/.m4a/_left.wav/g)" remix 1;
done

