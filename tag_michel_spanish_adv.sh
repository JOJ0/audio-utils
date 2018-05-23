#!/bin/bash
export IFS=$'\n' # split only on newlines
#set -f    # disable globbing
ARTIST="Michel Thomas"
ALBUM="Advanced Spanish with Michel Thomas 96k"
GENRE="Language"
YEAR="2006"
TRACKNO="1"

# adapt path, TITLE, READ_CMD and TAG_CMD magic here:
IFS=$'\n'; for i in cd*/*mp3; do
    #TITLE=$(echo "$i" | awk -F " - " '{ print $2 }' | sed -e 's/\.mp3//g')
    #TITLE=$(echo "$i" | sed 's:.*/::' | sed -e 's:^..-::g' | sed -e 's:\.m4a::g')
    TITLE=$(echo "$i" | sed 's:/:-:' | sed 's: No::g' | sed 's:cd:CD:g' |sed -e 's:\.mp3$: 96k:g')
    #DISCNO=$(echo "$i" | sed 's:(CD::' | sed 's:)/.*::' | sed -e 's:\.mp3$::g')
    DISCNO=""
    #TRACKNO=$(echo "$i" | sed 's:.*/::' | awk -F "-" '{ print $1 }' | sed -e 's:\.m4a::g')
    echo "######### $i #########"
    echo current tag: 
    READ_CMD="id3v2 -l \"$i\" | grep -v -e \"Encoded by\" -e \"Comments\" -e \"id3v2 tag info for\""
    #READ_CMD="mp4info \"$i\"" 
    eval $READ_CMD
    echo "" 
    echo -e "will set if doit:"
    echo -e "Title:\t\t$TITLE"
    echo -e "DiscNo:\t\t$DISCNO"
    echo -e "TrackNo:\t$TRACKNO"
    # !!! # -s cannot be used in combination with -2 # !!! #
    # id3v2 frame TPOS is discnumber
    TAG_CMD="id3v2 -2 -T \"$TRACKNO\" --TPOS \"$DISCNO\" -a \"$ARTIST\" -t \"$TITLE\" -A \"$ALBUM\" -g \"$GENRE\" \"$i\"" 
    #TAG_CMD="mp4tags -t \"$TRACKNO\" -a \"$ARTIST\" -s \"$TITLE\" -A \"$ALBUM\" -g \"$GENRE\" -y \"$YEAR\" \"$i\""
    if [ "$1" = "erase1" ]; then 
      echo "erasing id3v1 tag"
      id3v2 -s "$i"
    elif [ "$1" = "erase2" ]; then 
      echo "erasing id3v2 tag"
      id3v2 -d "$i"
    elif [ "$1" = "erase" ]; then 
      echo "erasing all id3 tags"
      id3v2 -D "$i"
    elif [ "$1" = "doit" ]; then
      echo ""
      ### that was a debug thing:
      #echo $TAG_CMD >> tag_michel_french_id3v2_cmd_list.sh
      ### these two lines are the actual tagging:
      eval $TAG_CMD
      echo "I did it!"
    else 
      echo ""
      echo $TAG_CMD
    fi
    echo -e "\n\n" 
    TRACKNO=$(($TRACKNO+1))
done
