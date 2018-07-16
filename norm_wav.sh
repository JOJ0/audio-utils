#!/bin/bash
if [ "$1" == "dry" ]; then
  DRY="echo"
fi

for WAV in ./*wav; do
  echo "$WAV:"
  #$DRY sox "$WAV" "$(echo $WAV | sed -e s/.wav/_amp.wav/g)" -V gain -n -l 0.1 ; # my version, what is h? add -V to see what auto fx are added by sox
  $DRY sox "$WAV" "$(echo $WAV | sed -e s/.wav/_amp.wav/g)" gain -nh dither -s ; # from manpage (same as --norm), what is dither -S, shaping or something
done

