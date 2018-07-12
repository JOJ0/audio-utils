#!/bin/bash
if [ "$1" == "dry" ]; then
  DRY="echo"
fi

for WAV in ./*wav; do
  # this works but better let sox detect the wavformat
  #$DRY alac "$M4A" | sox -t raw -e signed-integer -c 1 -b 16 -r 44100 - -c 1 -b 16 "$(echo $M4A | sed -e s/.m4a/_mono.wav/g)";
  #
  # just spit out fileinfo -> yes alac outputs a 16b signed-int PCM wav
  #$DRY alac "$M4A" | soxi -
  #
  # sox automagically detecting file type
  echo "$WAV:"
  #$DRY sox "$WAV" "$(echo $WAV | sed -e s/.wav/_amp.wav/g)" -V gain -n -l 0.1 ; # my version, what is h? add -V to see what auto fx are added by sox
  $DRY sox "$WAV" "$(echo $WAV | sed -e s/.wav/_amp.wav/g)" gain -nh dither -s ; # from manpage (same as --norm), what is dither -S, shaping or something
done

