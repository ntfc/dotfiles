###############################
# Exports
###############################

# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out the slash, period, angle brackets, dash here.
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
#export WORDCHARS='*?_[]~=&;!#$%^(){}'

# Browser
export BROWSER='chromium'
# editor
export VISUAL='vim'
export EDITOR='vim'

# pulseaudio with X11
export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/"

# set the default terminal
export TERM=rxvt-unicode-256color
