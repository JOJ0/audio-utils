#!/bin/bash
# convert flac files in current directory to Apple loss-less codec.
#for f in *.flac; do
#    ffmpeg -i "$f" -acodec alac "${f%.flac}.m4a"
#    #-map_meta_data $f:${f%.flac}.m4a;
#done

#!/usr/bin/env bash
set -e

convert_to_aiff() {
  flac="$1"
  aiff="${flac%.*}.aiff"

  flac -s -d --force-aiff-format -o "$aiff" "$flac"
}

if [ $# -ne 1 ]; then
  echo "usage: $0 dir"
  echo "requirements: Mac OS and flac installed"
  exit 1
fi

for file in "$1"/*flac; do
  echo -n "."
  convert_to_aiff "$file"
done

echo " done"
