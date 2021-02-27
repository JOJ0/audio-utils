#!/bin/bash
DRY="echo"
if [ "$1" == "doit" ]; then
  DRY=""
fi

for WAV in ./*wav; do
  # sox automagically detecting file type
  echo "$MP3"
  $DRY sox -c 2 -b 24 "$(echo $WAV)" "$(echo $WAV | sed -e s/.wav/_mono.wav/g)" remix -;
done

