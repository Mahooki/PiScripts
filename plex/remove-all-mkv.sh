#!/bin/bash

# Removes all mkv files in all subdirs of the dir given in the first argument

PWD=$(pwd)
DIR=$1

cd $DIR

filetype=".mkv"
total=$(find . -name "*$filetype" | wc -l)

counter=1
shopt -s globstar nullglob
for fn in **/*$filetype; do
  printf "\n($counter/$total)\nRemoved file: $PWD/$fn\n"
  rm "$fn"
  ((counter++))
done