#!/bin/sh

# symlinked to /usr/lib/systemd/system-sleep/hooks.sh
# $1 = pre or post
# $2 = suspend, hibernate or hybrid-sleep

set -x

USER=$(who -s | grep "(:0)" | awk '{print $1}')

case $1/$2 in
  pre/*)
    #su $USER -c 'export DISPLAY=:0.0; xscreensaver-command -lock' &
    su $USER -c 'export DISPLAY=:0.0; slock' &
    # pause VLC. Taken from http://stackoverflow.com/a/43156436
    # TODO: need to sort out the dbus mess..
    dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
    ;;
  post/*)
    # not working???? maybe AC_STATE is not updated? wtf?
    (sleep 5s && /home/$USER/.scripts/power/powersave) &
    numlockx on &
    ;;
esac
