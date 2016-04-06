#!/bin/sh

# symlinked to /usr/lib/systemd/system-sleep/hooks.sh
# $1 = pre or post
# $2 = suspend, hibernate or hybrid-sleep

USER=$(who -s | grep "(:0)" | awk '{print $1}')

case $1/$2 in
  pre/*)
    su $USER -c 'export DISPLAY=:0.0; xscreensaver-command -lock' &
    if [[ ! -z "`pidof spotify`" ]]; then
      su $USER -c 'export DISPLAY=:0.0; spotifycli -s' &
    fi
    ;;
  post/*)
    # not working???? maybe AC_STATE is not updated? wtf?
    (sleep 5s && /home/$USER/.scripts/power/powersave) &
    numlockx on &
    ;;
esac
