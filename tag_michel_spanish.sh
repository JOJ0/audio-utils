#!/bin/bash
export IFS=$'\n' # split only on newlines
#set -f    # disable globbing
ARTIST="Michel Thomas"
ALBUM="Spanish with Michel Thomas"
GENRE="Language"
YEAR=""
TRACKNO="1"

# adapt path, TITLE, READ_CMD and TAG_CMD magic here:
IFS=$'\n'; for i in \(CD*/*mp3; do
    #TITLE=$(echo "$i" | awk -F " - " '{ print $2 }' | sed -e 's/\.mp3//g')
    #TITLE=$(echo "$i" | sed 's:.*/::' | sed -e 's:^..-::g' | sed -e 's:\.m4a::g')
    #TITLE=$(echo "$i" | sed 's:.*/::' | sed 's:frFound:CD:' | sed 's:l:-Track:' | sed -e 's:\.mp3$::g')
    TITLE=$(echo "$i" | sed 's:(::' | sed 's:)/....:-:' | sed -e 's:\.mp3$::g')
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
    if [ "$1" = "doit"  ]; then
      echo ""
      ### comment out these two lines for erasign v1 and v2 tags:
      #id3v2 -s "$i"
      #id3v2 -d "$i"
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
