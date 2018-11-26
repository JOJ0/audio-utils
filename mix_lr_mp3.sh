#!/bin/bash
DRY="echo"
if [ "$1" == "doit" ]; then
  DRY=""
fi

for MP3 in ./*mp3; do
  # this works but better let sox detect the wavformat
  #$DRY alac "$MP3" | $DRY sox -t raw -e signed-integer -c 1 -b 16 -r 44100 - -c 1 -b 16 "$(echo $MP3 | sed -e s/.mp3/_mono.wav/g)";
  #
  # just spit out fileinfo -> yes alac outputs a 16b signed-int PCM wav
  #$DRY alac "$MP3" | $DRY soxi -
  #
  # sox automagically detecting file type
  echo "### $MP3 ###"
  # mix down to STEREO file
  #$DRY alac "$MP3" | $DRY sox - -c 2 -b 16 "$(echo $MP3 | sed -e s/.mp3/_both.wav/g)" remix 1-2;
  # mix down to MONO file and convert to vbr mp3
  # sed version
  #$DRY alac "$MP3" | $DRY sox - -b 16 -t wav - remix 1-2 | lame -q 0 -vbr-new -V 0 - "$(echo $MP3 | sed -e s/.mp3/_both.mp3/g)"
  # parameter expansion - substring shizzle - for filename
  #echo "${MP3:0:4} ${MP3:5} ${MP3/.mp3/.mp3}"
  # parameter expansion substring - for id3 tags
  TRACKNO=${MP3:2:2}
  ARTIST="Tim Richards"
  TITLE="${MP3:5}"
  TITLE="${TITLE%.*}"
  ALBUM="Exploring Jazz Piano Vol 1 BOTH"
  FILENAME="$TRACKNO ${TITLE}_BOTH.mp3" 
  $DRY alac "$MP3" | $DRY sox - -b 16 -t wav - remix 1-2 | $DRY lame -q 0 -vbr-new -V 0 --id3v2-only --tn "$TRACKNO" --ta "$ARTIST" --ty "$YEAR" --tl "$ALBUM" --tt "$TITLE BOTH" - "$FILENAME" 
done

