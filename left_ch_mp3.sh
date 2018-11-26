#!/bin/bash
DRY="echo"
if [ "$1" == "doit" ]; then
  DRY=""
fi

for MP3 in ./*mp3; do
  # this works but better let sox detect the wavformat
  #$DRY alac "$MP3" | sox -t raw -e signed-integer -c 1 -b 16 -r 44100 - -c 1 -b 16 "$(echo $MP3 | sed -e s/.mp3/_mono.wav/g)";
  #
  # just spit out fileinfo -> yes alac outputs a 16b signed-int PCM wav
  #$DRY alac "$MP3" | soxi -
  #
  # sox automagically detecting file type
  echo "$MP3"
  $DRY alac "$MP3" | sox - -c 1 -b 16 "$(echo $MP3 | sed -e s/.mp3/_left.wav/g)" remix 1;
done

