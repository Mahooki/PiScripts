#!/bin/bash
# Converts all mkv files in all subdirs of the dir given in the first argument
PWD=$(pwd)
DIR=$1

cd $DIR

filetype=".mkv"
total=$(find . -name "*$filetype" | wc -l)

if [ $total = 0 ]; then
  printf "No mkv files to convert or delete, exiting." 
  exit 0
fi

counter=1
shopt -s globstar nullglob
for fn in **/*$filetype; do
  start=$SECONDS
  printf "\n($counter/$total)\nConverting: $PWD/$fn\n"
  # -y to overwrite any mp4 files with same name
  # (i.e. from prior partial conversion)
  ffmpeg -hide_banner -loglevel error -y -i "$fn" -codec copy "${fn%.*}.mp4"
  duration=$((SECONDS-start))
  printf "Completed in $duration seconds\n"
  ((counter++))
done

# Removes all mkv files in all subdirs of the dir given in the first argument
for fn in **/*$filetype; do
  rm "$fn"
done
printf "\nRemoved $total mkv files\n"
exit 0