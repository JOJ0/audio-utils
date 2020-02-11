#!/bin/bash
# convert flac files in current directory to Apple loss-less codec.
#for f in *.flac; do
#    ffmpeg -i "$f" -acodec alac "${f%.flac}.m4a"
#    #-map_meta_data $f:${f%.flac}.m4a;
#done

#!/usr/bin/env bash
set -e

convert_to_alac() {
  flac="$1"
  aiff="${flac%.*}.aiff"
  alac="${flac%.*}.m4a"

  flac -s -d --force-aiff-format -o "$aiff" "$flac"
  afconvert -f m4af -d alac "$aiff" "$alac"
  rm "$aiff"
}

if [ $# -ne 1 ]; then
  echo "usage: $0 dir"
  echo "requirements: Mac OS and flac installed"
  exit 1
fi

for file in "$1"; do
  echo -n "."
  convert_to_alac "$file"
done

echo " done"
