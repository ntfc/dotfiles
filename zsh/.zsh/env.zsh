###############################
# Exports
###############################

typeset -U path
path+=(
  "/usr/share/rvm/bin/"
  "$HOME/.scripts/"
  "$HOME/.rvm/bin/"
  "$HOME/.go/bin"
  "$HOME/.local/bin" # python-pip
)
export PATH

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

export GOPATH=~/.go

# NOTE: this must match with what is defined in .xprofile
if hash gnome-keyring-daemon 2>/dev/null; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi
