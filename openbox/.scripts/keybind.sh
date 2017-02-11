#!/bin/bash

# credits to hbekel from archlinux bbs
# https://bbs.archlinux.org/viewtopic.php?id=115418

if (($# < 2)); then
  echo "Usage: keybind.sh <class> <key>"
  exit 1;
fi

class="$1"
key="$2"

xdotool getwindowfocus key --window "$class" "$key"
