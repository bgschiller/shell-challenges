#!/usr/bin/env bash

trap 'not_today' 0 1 2 3 6 14 15

WORDS=(canteloupe pineapple apple pear cranberry pumpkin lemon lime)
not_today() {
  speak
}

speak() {
  sudo osascript -e "set Volume 5"
  local w=${WORDS[RANDOM%${#WORDS[@]}+1]}
  echo $w
  say $w
}

while :
do
  speak
  sleep 30
done