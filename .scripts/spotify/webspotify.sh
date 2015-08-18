#!/usr/bin/env sh

# $1 = play|next|prev|volu|vold

# https://community.spotify.com/t5/Help-Desktop-Linux-Windows-Web/Hotkeys/td-p/318194

# TODO: Spotify web player shortcuts:
#  - space: play/pause: DONE
#  - shift+left: previous
#  - shift+right: next
#  - ctrl+alt+down: volume down
#  - ctrl+alt+up: volume up


case "$1" in
  "play")
    key="space"
    ;;
  *)
    echo
    echo "Invalid option"
    echo
    echo "  play|next|prev|volu|vold"
    exit 1
  ;;
esac

webplayer_winid="$(wmctrl -lx | grep Spotify | grep crx_ | awk '{print $1}')"
if [[ ! -z "$webplayer_winid" ]]; then
  current_desktop=$(xdotool get_desktop)
  xdotool windowactivate --sync $webplayer_winid key "$key"
  xdotool windowminimize $webplayer_winid
  xdotool set_desktop $current_desktop
fi
