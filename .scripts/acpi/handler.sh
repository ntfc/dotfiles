#!/bin/bash
#
# called from /etc/acpi/events/power. This script should deal with $1:
#  * ac_adapter
#  * button/power
#  * button/sleep
#  * button/lid
# 
# if $4 = 00000000, battery ON, otherwise, battery OFF
#
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
  				su nc -c 'export DISPLAY=:0.0 ; /usr/bin/pygtk-shutdown-systemd'

			;;
		esac
	;;
	hotkey)
		case "$3" in
			00000034) # screen off
				su nc -c 'export DISPLAY=:0.0 ; xscreensaver-command -lock' &
			;;
			00000033) # screen on

				
			;;
		esac
	;;
esac

