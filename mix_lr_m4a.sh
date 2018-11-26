#!/bin/bash
DRY="echo"
if [ "$1" == "doit" ]; then
  DRY=""
fi

for M4A in ./*m4a; do
  # this works but better let sox detect the wavformat
  #$DRY alac "$M4A" | $DRY sox -t raw -e signed-integer -c 1 -b 16 -r 44100 - -c 1 -b 16 "$(echo $M4A | sed -e s/.m4a/_mono.wav/g)";
  #
  # just spit out fileinfo -> yes alac outputs a 16b signed-int PCM wav
  #$DRY alac "$M4A" | $DRY soxi -
  #
  # sox automagically detecting file type
  echo "### $M4A ###"
  # mix down to STEREO file
  #$DRY alac "$M4A" | $DRY sox - -c 2 -b 16 "$(echo $M4A | sed -e s/.m4a/_both.wav/g)" remix 1-2;
  # mix down to MONO file and convert to vbr mp3
  # sed version
  #$DRY alac "$M4A" | $DRY sox - -b 16 -t wav - remix 1-2 | lame -q 0 -vbr-new -V 0 - "$(echo $M4A | sed -e s/.m4a/_both.mp3/g)"
  # parameter expansion - substring shizzle - for filename
  #echo "${M4A:0:4} ${M4A:5} ${M4A/.m4a/.mp3}"
  # parameter expansion substring - for id3 tags
  TRACKNO=${M4A:2:2}
  ARTIST="Tim Richards"
  TITLE="${M4A:5}"
  TITLE="${TITLE%.*}"
  ALBUM="Exploring Jazz Piano Vol 1 BOTH"
  FILENAME="$TRACKNO ${TITLE}_BOTH.mp3" 
  $DRY alac "$M4A" | $DRY sox - -b 16 -t wav - remix 1-2 | $DRY lame -q 0 -vbr-new -V 0 --id3v2-only --tn "$TRACKNO" --ta "$ARTIST" --ty "$YEAR" --tl "$ALBUM" --tt "$TITLE BOTH" - "$FILENAME" 
done

