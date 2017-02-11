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

USER=$(who -s | grep "(:0)" | awk '{print $1}')
MPD=$(pidof mpd)
SPOTIFY=$(pidof spotify)

case "$1" in
  ac_adapter)
    case "$4" in
      00000000)
        # Battery mode
        /home/"$USER"/.scripts/power/powerdown &
      ;;
      00000001)
        # AC mode
        /home/"$USER"/.scripts/power/powerup &
      ;;
    esac
  ;;
  button/power)
    case "$2" in
      PBTN|PWRF)
        logger "Power button pressed"
          su "$USER" -c 'export DISPLAY=:0.0 ; /usr/bin/pygtk-shutdown-systemd'
      ;;
    esac
  ;;
  button/sleep)
    # let systemd-logind handle suspend events
    #systemctl suspend
  ;;
  video/brightnessup)
    # check if light command exists
    if hash light 2>/dev/null; then
      light -A 3 &
    fi
  ;;
  video/brightnessdown)
    # check if light command exists
    if hash light 2>/dev/null; then
      light -U 3 &
    fi
  ;;
  button/volumeup)
        su "$USER" -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u "$USER"`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/"$USER"/.scripts/pacontrol up 1' &
  ;;
  button/volumedown)
        su "$USER" -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u "$USER"`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/"$USER"/.scripts/pacontrol down 1' &
  ;;
  button/mute)
        su "$USER" -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u "$USER"`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/"$USER"/.scripts/pacontrol mute 1' &
  ;;
  cd/play)
    [[ ! -z "$SPOTIFY" ]] && su "$USER" -c 'export DISPLAY=:0.0 ; spotifycli -p' &
    [[ ! -z "$MPD" ]] && su "$USER" /home/"$USER"/.scripts/acpi/mpd-control "$1" &
    su "$USER" -c 'export DISPLAY=:0.0 ; /home/"$USER"/.scripts/spotify/webspotify.sh play' &
  ;;
  cd/next)
    [[ ! -z "$SPOTIFY" ]] && su "$USER" -c 'export DISPLAY=:0.0 ; spotifycli -n' &
    [[ ! -z "$MPD" ]] && su "$USER" /home/"$USER"/.scripts/acpi/mpd-control "$1" &
  ;;
  cd/prev)
    [[ ! -z "$SPOTIFY" ]] && su "$USER" -c 'export DISPLAY=:0.0 ; spotifycli -r' &
    [[ ! -z "$MPD" ]] && su "$USER" /home/"$USER"/.scripts/acpi/mpd-control "$1" &
  ;;
  cd/stop)
    [[ ! -z "$SPOTIFY" ]] && su "$USER" -c 'export DISPLAY=:0.0 ; spotifycli -s' &
    [[ ! -z "$MPD" ]] && su "$USER" /home/"$USER"/.scripts/acpi/mpd-control "$1" &
  ;;
  hotkey)
    case "$3" in
      00000034) # screen off
        su "$USER" -c 'export DISPLAY=:0.0 ; xscreensaver-command -lock' &
      ;;
      00000033) # screen on
      ;;
      00000040|00000041|00000043|00000045) # multimedia keys
        /home/"$USER"/.scripts/acpi/mpd-control "$3"
      ;;
      00000032) # mute
        su "$USER" -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u "$USER"`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/"$USER"/.scripts/pacontrol mute 1' &
      ;;
      00000031) # vol down
        su "$USER" -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u "$USER"`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/"$USER"/.scripts/pacontrol down 1' &
      ;;
      00000030) # vol up
        su "$USER" -c 'export PULSE_RUNTIME_PATH="/run/user/"`id -u "$USER"`"/pulse/" ; \
          export DISPLAY=:0.0 ; \
          /home/"$USER"/.scripts/pacontrol up 1' &
      ;;
      00000055) # calculator
        su "$USER" -c 'export DISPLAY=:0.0 ; /usr/bin/speedcrunch' &
    esac
  ;;
esac

