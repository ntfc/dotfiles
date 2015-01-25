#!/bin/sh

if [[ "$USER" == "root" ]]; then
  su ntfc -c 'export DISPLAY=:0.0; arandr' &
else
  arandr &
fi
