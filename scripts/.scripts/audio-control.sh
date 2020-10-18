#!/usr/bin/env bash

# $1 = (prev|next|toggle)

if hash mpc 2>/dev/null; then
  mpc $1
fi

if hash clementine 2>/dev/null; then
  if pidof clementine >/dev/null; then
    case "$1" in
      "prev")
        clementine --previous
        ;;
      "next")
        clementine --next
        ;;
      "toggle")
        clementine --play-pause
        ;;
    esac
  fi
fi
