###############################
# Exports
###############################

typeset -U path
# at the end of this file we export PATH, since the path variable is
# incremented throughout this file
path+=(
  "$HOME/.scripts/"
)

# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out the slash, period, angle brackets, dash here.
export WORDCHARS='*?[]~=&;!#$%^(){}<>'

# Browser
export BROWSER='firefox'
# editor
export VISUAL='vim'
export EDITOR='vim'

# pulseaudio with X11
export PULSE_RUNTIME_PATH="/run/user/"`id -u`"/pulse/"

# java stuff
# done in /etc/environment as explained here:
# https://wiki.archlinux.org/index.php/Java_Runtime_Environment_Fonts

if hash go 2>/dev/null; then
  export GOPATH=~/.local/share/go
  path+=(
    "$HOME/.local/share/go/bin"
  )
fi

# NOTE: this must match with what is defined in .xprofile
if hash gnome-keyring-daemon 2>/dev/null; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# configure virtualenvwrapper
if hash virtualenvwrapper.sh 2>/dev/null; then
  export WORKON_HOME=~/.local/share/virtualenvs/
  source virtualenvwrapper.sh
fi

# NOTE: this must be the last instruction!
export PATH
