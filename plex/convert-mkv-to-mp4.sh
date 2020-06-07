#!/bin/bash
# Converts all mkv files in all subdirs of the dir given in the first argument

PWD=$(pwd)
DIR=$1

cd $DIR

filetype=".mkv"
total=$(find . -name "*$filetype" | wc -l)

counter=1
shopt -s globstar nullglob
for fn in **/*$filetype; do
  printf "\n($counter/$total)\nBeginning to convert file: $PWD/$fn\n"
  # -y to overwrite any mp4 files with same name
  # (i.e. from prior partial conversion)
  ffmpeg -y -i "$fn" -codec copy "${fn%.*}.mp4"
  printf "\nFinished converting to: $PWD/${fn%.*}.mp4\n"
  ((counter++))
done