#!/usr/bin/env bash

trap 'not_today' 0 1 2 3 6 14 15

WORDS=(canteloupe pineapple apple pear cranberry pumpkin lemon lime orange grape grapefruit pomegranate kumquat tangerine clementine banana coconut papaya mango apricot plum strawberry peach cherry blueberry jamberry nectarine tangelo kiwifruit watermelon raspberry)
not_today() {
  speak
}

speak() {
  osascript -e "set Volume 5"
  local w=${WORDS[RANDOM%${#WORDS[@]}+1]}
  echo $w
  say $w
}

while :
do
  speak
  sleep 30
done