#!/bin/bash
IFS=$'\n' # split only on newlines
#set -f    # disable globbing
ARTIST="Andrew D. Gordon"
ALBUM="60 Of The Funkiest Keyboard Riffs Known To Mankind"
GENRE="Piano Practice"
YEAR="1995"

# adapt ls here:
for i in $(ls *Riff*mp3); do
    #TITLE=$(echo "$i" | awk -F " - " '{ print $2 }' | sed -e 's/\.mp3//g')
    TITLE=$(echo "$i" | awk -F "-" '{ print $2 }' | sed -e 's/\.mp3//g')
    TRACKNO=$(echo "$i" | sed -e 's,.*Riff,,g' | sed -e 's/\.mp3//g')
    echo file: "$i" ...
    echo current tag: 
    id3v2 -l "$i" | grep -v -e "Encoded by" -e "id3v2 tag info for"
    echo "" 
    echo will set "$TITLE" as title if \$1 is doit;
    echo will set "$TRACKNO" as track number if \$1 is doit;
    if [ "$1" = "doit"  ]; then
      echo "" 
      id3v2 -2 -T "$TRACKNO" -a "$ARTIST" -t "$TITLE" -A "$ALBUM" -g "$GENRE" -y "$YEAR" -c "" $i
    fi
    echo -e "\n\n" 
done
