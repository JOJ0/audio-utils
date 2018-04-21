#!/bin/bash
export IFS=$'\n' # split only on newlines
#set -f    # disable globbing
ARTIST="pianowithwillie.com"
ALBUM="funkpianolessons.com"
GENRE="Piano Practice"
YEAR="2015"
TRACKNO="1"

# adapt path, TITLE, READ_CMD and TAG_CMD magic here:
IFS=$'\n'; for i in */mp3*/*m4a; do
#for i in FPL-02-TECH2/mp3*/*m4a; do
    #TITLE=$(echo "$i" | awk -F " - " '{ print $2 }' | sed -e 's/\.mp3//g')
    #TITLE=$(echo "$i" | sed 's:.*/::' | sed -e 's:^..-::g' | sed -e 's:\.m4a::g')
    TITLE=$(echo "$i" | sed 's:.*/::' |  sed -e 's:\.m4a::g')
    #TRACKNO=$(echo "$i" | sed 's:.*/::' | awk -F "-" '{ print $1 }' | sed -e 's:\.m4a::g')
    echo "######### $i #########"
    echo current tag: 
    #READ_CMD="id3v2 -l \"$i\" | grep -v -e \"Encoded by\" -e \"Comments\" -e \"id3v2 tag info for\""
    READ_CMD="mp4info \"$i\"" 
    eval $READ_CMD
    echo "" 
    echo -e "will set if doit:"
    echo -e "Title:\t\t$TITLE"
    echo -e "TrackNo:\t$TRACKNO"
    #TAG_CMD="id3v2 -s -2 -T \"$TRACKNO\" -a \"$ARTIST\" -t \"$TITLE\" -A \"$ALBUM\" -g \"$GENRE\" -y \"$YEAR\" \"$i\""
    TAG_CMD="mp4tags -t \"$TRACKNO\" -a \"$ARTIST\" -s \"$TITLE\" -A \"$ALBUM\" -g \"$GENRE\" -y \"$YEAR\" \"$i\""
    if [ "$1" = "doit"  ]; then
      echo ""
      eval $TAG_CMD
      echo "I did it!"
    else 
      echo ""
      echo $TAG_CMD
    fi
    echo -e "\n\n" 
    TRACKNO=$(($TRACKNO+1))
done
