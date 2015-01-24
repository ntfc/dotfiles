#!/bin/sh

STATE=$(synclient | grep TouchpadOff | awk '{print $3}')

if [[ "$STATE" == "0" ]]; then
  synclient TouchpadOff=1
  STATE="off"
else
  synclient TouchpadOff=0
  STATE="on"
fi

if [[ "$USER" == "root" ]]; then
  su ntfc -c 'export DISPLAY=:0.0; notify-send "Touchpad '$STATE'"'
else
  notify-send "Touchpad $STATE"
fi

