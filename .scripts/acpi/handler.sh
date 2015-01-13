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

USER=ntfc

case "$1" in
  ac_adapter)
    case "$4" in
      00000000)
        # Battery mode
        /home/$USER/.scripts/power/powerdown &
      ;;
      00000001)
        # AC mode
        /home/$USER/.scripts/power/powerup &
      ;;
    esac
  ;;
  button/power)
    case "$2" in
      PBTN|PWRF)
        logger "Power button pressed"
          su $USER -c 'export DISPLAY=:0.0 ; /usr/bin/pygtk-shutdown-systemd'

      ;;
    esac
  ;;
  video/brightnessup)
    light -A 10 &
  ;;
  video/brightnessdown)
    light -U 10 &
  ;;
  button/volumeup)
        su $USER -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u $USER`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/$USER/.scripts/pacontrol up 1' &
  ;;
  button/volumedown)
        su $USER -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u $USER`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/$USER/.scripts/pacontrol down 1' &
  ;;
  button/mute)
        su $USER -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u $USER`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/$USER/.scripts/pacontrol mute 1' &
  ;;
esac
