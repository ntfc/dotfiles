#!/usr/bin/env bash

# Copied and modified from https://gist.github.com/XenGi/5499771

# The following script toggles between the internal monitor and an external
# monitor.
#
# by XenGi
##### edit config #####

set -x
set -e
UDEV_RULE_NAME=99-hdmi-hotplug.rules
export DISPLAY=:0
USER=$(who | grep $DISPLAY | head -1 | cut -f 1 -d ' ')

INTERNAL=$(su "$USER" -c "xrandr --current | grep -E -i '(edp|lvds)' | cut -d' ' -f 1")
EXTERNAL=$(su "$USER" -c "xrandr --current | grep -i hdmi | head -n1 | cut -d' ' -f 1")
##### end config  #####

# Check if we are root
if [[ $EUID -ne 0 ]] ; then
    echo "This script must be run as root" 
    exit 1
fi

if [[ -z "$USER" ]]; then
  echo "Could not find user '$USER'"
  exit 1
fi

# check for udev rule
if [[ ! -f "/etc/udev/rules.d/${UDEV_RULE_NAME}" ]] ; then
    echo "No udev rule found. Put '${UDEV_RULE_NAME}' in '/etc/udev/rules.d' and execute 'udevadm control --reload' as root."
    exit
fi

export XAUTHORITY="/home/$USER/.Xauthority"

STATUS=$(su $USER -c "xrandr --current | grep $EXTERNAL | cut -d \  -f 2")

if [[ "$STATUS" == "disconnected" ]] ; then
    # switch EXTERNAL on and INTERNAL off
    su $USER -c "xrandr --output $INTERNAL --off"
    su $USER -c "xrandr --output $EXTERNAL --auto"
    # set EXTERNAL output as primary audio
    # NOTE: I do not want this because most of the time my I connect to HDMI monitors without sound
    #su $USER -c "pactl set-card-profile 0 output:hdmi-surround"
fi

if [[ "$STATUS" == "connected" ]] ; then
    # switch EXTERNAL off and INTERNAL on
    su $USER -c "xrandr --output $EXTERNAL --off"
    su $USER -c "xrandr --output $INTERNAL --auto"
    # set internal speakers and mic as primary audio
    su $USER -c "pactl set-card-profile 0 output:analog-stereo+input:analog-stereo"
fi

