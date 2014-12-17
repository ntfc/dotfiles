#!/bin/bash
#
# called from /etc/acpi/events/power. This script should deal with $1:
#  * ac_adapter
#  * button/power
#  * button/sleep
#  * button/lid
# 
# if $4 = 00000000, battery ON, otherwise, battery OFF
#
# $1 = ac_adapter|button/power|button/sleep|button/lid
# $2 = 
# $3 = 
# $4 = 00000000 or 00000001

case "$1" in
  ac_adapter)
    case "$4" in
      00000000)
        # Battery mode
        /home/nc/.scripts/power/powerdown &
      ;;
      00000001)
        # AC mode
        /home/nc/.scripts/power/powerup &
      ;;
    esac
  ;;
  button/power)
    case "$2" in
      PBTN|PWRF)
        logger "Power button pressed"
          su nc -c 'export DISPLAY=:0.0 ; /usr/bin/pygtk-shutdown-systemd'

      ;;
    esac
  ;;
  hotkey)
    case "$3" in
      00000034) # screen off
        su nc -c 'export DISPLAY=:0.0 ; xscreensaver-command -lock' &
      ;;
      00000033) # screen on
      ;;
      00000040|00000041|00000043|00000045) # multimedia keys
        /home/nc/.scripts/acpi/mpd-control "$3"
      ;;
      00000032) # mute
        su nc -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/nc/.scripts/pacontrol mute 1' &
      ;;
      00000031) # vol down
        su nc -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/nc/.scripts/pacontrol down 1' &
      ;;
      00000030) # vol up
        su nc -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/nc/.scripts/pacontrol up 1' &
      ;;
    esac
  ;;
esac

