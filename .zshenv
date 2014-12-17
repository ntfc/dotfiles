###############################
# Exports
###############################

# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out the slash, period, angle brackets, dash here.
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
#export WORDCHARS='*?_[]~=&;!#$%^(){}'

# editor
export EDITOR='vim'
# Browser
export BROWSER='chromium'

# pulseaudio with X11
export PULSE_RUNTIME_PATH="/run/user/"`id -u nc`"/pulse/"
