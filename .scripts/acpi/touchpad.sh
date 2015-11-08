#!/bin/sh

STATE=$(synclient | grep TouchpadOff | awk '{print $3}')
USER=who -s | grep "(:0)" | awk '{print $1}'

if [[ "$STATE" == "0" ]]; then
  synclient TouchpadOff=1
  STATE="off"
else
  synclient TouchpadOff=0
  STATE="on"
fi

if [[ "$USER" == "root" ]]; then
  su $USER -c 'export DISPLAY=:0.0; notify-send "Touchpad '$STATE'"'
else
  notify-send "Touchpad $STATE"
fi

