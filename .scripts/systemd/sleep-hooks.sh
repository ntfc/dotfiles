#!/bin/sh

# symlinked to /usr/lib/systemd/system-sleep/hooks.sh
# $1 = pre or post
# $2 = suspend, hibernate or hybrid-sleep

USER=ntfc
case $1/$2 in
  pre/*)
    if [[ ! -z "`pidof spotify`" ]]; then
      su $USER -c 'export DISPLAY=:0.0; spotifycli -s' &
    fi
    su $USER -c 'export DISPLAY=:0.0; xscreensaver-command -lock'
    ;;
  post/*)
    su $USER -c '/.scripts/power/powersave' &
    numlockx on &
    ;;
esac
