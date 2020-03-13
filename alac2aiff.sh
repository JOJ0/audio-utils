#!/usr/bin/env bash
# convert apple lossles files in given directory ($1/*.m4a) to AIFF (*.aiff).

set -e

EXT='m4a'

convert_to_aiff() {
  alac="$1"
  aiff="${alac%.*}.aiff"

  afconvert -f AIFF -d BEI16 "$alac" -o "$aiff"
}

if [ $# -ne 1 ]; then
  echo "usage: $0 dir"
  echo "requirements: Mac OS and afconvert installed"
  exit 1
fi

for file in "$1"/*$EXT; do
  echo -n "."
  convert_to_aiff "$file"
done

echo " done"
