#!/bin/sh

USER=who -s | grep "(:0)" | awk '{print $1}'

if [[ $EUID == 0 ]]; then
  su $USER -c 'export DISPLAY=:0.0; arandr' &
else
  arandr &
fi
