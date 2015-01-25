#!/bin/sh

# symlinked to /usr/lib/systemd/system-sleep/hooks.sh
# $1 = pre or post
# $2 = suspend, hibernate or hybrid-sleep

USER=ntfc
case $1/$2 in
  pre/*)
    su $USER -c 'export DISPLAY=:0.0; xscreensaver-command -lock'
    if [[ ! -z "`pidof spotify`" ]]; then
      su $USER -c 'export DISPLAY=:0.0; spotifycli -s'
    fi
    ;;
  post/*)
    su $USER -c '/.scripts/power/powersave'
    ;;
esac
