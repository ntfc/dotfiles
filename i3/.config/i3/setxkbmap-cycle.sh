#!/usr/bin/env bash

set -e

if ! hash setxkbmap; then
  echo "setxkbmap not installed"
  exit 1
fi

current_layout="$(setxkbmap -query | grep layout | awk '{print $2}')"

# us -> pt
# pt -> de
# de -> us

case "$current_layout" in
  us)
    setxkbmap -layout pt
    ;;
  pt)
    setxkbmap -layout de
    ;;
  de)
    setxkbmap -layout us
    ;;
  *) # change to default US layout
    setxkbmap -layout us
    ;;
esac

setxkbmap -query | grep layout | awk '{print $2}'
