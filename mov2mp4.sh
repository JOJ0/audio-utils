#!/bin/bash
export IFS=$'\n' # split only on newlines
#set -f    # disable globbing

DRY="echo"
if [ "$1" == "doit" ]; then
  DRY=""
fi

function GetBaseName() {
  FILENAME=$(basename $1)
  echo ${FILENAME%.*}
}

EXT=mov
VID_NO=1

CUT1="-ss 00:00:00 -to 00:10:10"
#CUT2=""
#CUT2=""
#CUT4=""
#CUT4=""
#CUT5=""
#CUT6="-ss 00:00:00 -to 00:09:08"
#CUT7=""
#CUT8=""
#CUT9=""


IFS=$'\n'; for i in *$EXT; do
    echo "####  Video $VID_NO: $i  ####"
	NAME=$(GetBaseName "$i")
    echo $(eval echo "\$CUT""$VID_NO")
    $DRY ffmpeg -i "${NAME}.mov" -c:v libx264 -preset veryfast -crf 22 -c:a copy $(eval echo "\$CUT""$VID_NO") "${NAME}.mp4"
    echo "------------------------------------------------------------------------------------"
    echo ""
    VID_NO=$(($VID_NO+1))
done


