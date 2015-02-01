#!/bin/sh

# symlinked to /usr/lib/systemd/system-sleep/hooks.sh
# $1 = pre or post
# $2 = suspend, hibernate or hybrid-sleep

NC_USER=ntfc

case $1/$2 in
  pre/*)
    su $NC_USER -c 'export DISPLAY=:0.0; xscreensaver-command -lock' &
    if [[ ! -z "`pidof spotify`" ]]; then
      su $NC_USER -c 'export DISPLAY=:0.0; spotifycli -s' &
    fi
    ;;
  post/*)
    # not working???? maybe AC_STATE is not updated? wtf?
    (sleep 5s && /home/$NC_USER/.scripts/power/powersave) &
    numlockx on &
    ;;
esac
