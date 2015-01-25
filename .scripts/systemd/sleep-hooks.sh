#!/bin/sh

# symlinked to /usr/lib/systemd/system-sleep/hooks.sh
# $1 = pre or post
# $2 = suspend, hibernate or hybrid-sleep

NC_USER="ntfc"

case $1/$2 in
  pre/*)
    if [[ ! -z "`pidof spotify`" ]]; then
      su $NC_USER -c 'export DISPLAY=:0.0; spotifycli -s'
    fi
    su $NC_USER -c 'export DISPLAY=:0.0; xscreensaver-command -lock'
    ;;
  post/*)
    /home/$NC_USER/.scripts/power/powersave &> /dev/null
    numlockx on &
    ;;
esac
