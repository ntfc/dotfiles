#!/bin/bash
#
# called from /etc/acpi/events/anything This script should deal with everything
# acpid related.
#
# todo: update these values...
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
        su nc -c 'export DISPLAY=:0.0 ; /usr/bin/obshutdown -c /home/nc/.config/obshutdown'
      ;;
    esac
  ;;
  button/mute)
    su nc -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/" ; \
      export DISPLAY=:0.0 ; \
      /home/nc/.scripts/pacontrol mute 1' &
    ;;
  button/volumedown)
    su nc -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/" ; \
      export DISPLAY=:0.0 ; \
      /home/nc/.scripts/pacontrol down 1' &
    ;;
  button/volumeup)
    su nc -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/" ; \
      export DISPLAY=:0.0 ; \
      /home/nc/.scripts/pacontrol up 1' &
    ;;
  cd/prev|cd/stop|cd/next|cd/play)
    /home/nc/.scripts/acpi/mpd-control "$1"
    ;;
  hotkey)
    case "$3" in
      00000034) # screen off
        su nc -c 'export DISPLAY=:0.0 ; xscreensaver-command -lock' &
      ;;
      00000033) # screen on
      ;;
      00000055) # calculator
        su nc -c 'export DISPLAY=:0.0 ; /usr/bin/speedcrunch' &
    esac
  ;;
esac

