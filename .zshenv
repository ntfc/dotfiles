###############################
# Exports
###############################

# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out the slash, period, angle brackets, dash here.
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Browser
export BROWSER='chromium'
# editor
export VISUAL='vim'
export EDITOR='vim'

# pulseaudio with X11
export PULSE_RUNTIME_PATH="/run/user/"`id -u ntfc`"/pulse/"

# java stuff
# done in /etc/environment as explained here:
# https://wiki.archlinux.org/index.php/Java_Runtime_Environment_Fonts
#
