# The following lines were added by compinstall

zstyle ':completion:*' completer  _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select 
zstyle ':completion:*' rehash true
zstyle :compinstall filename '/home/nc/.zshrc'

# auto completion for command aliases
setopt completealiases

# command completion
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory
unsetopt beep
# End of lines configured by zsh-newuser-install

# My configs
# load my aliases
source ~/.scripts/aliasrc
source ~/.scripts/gitaliasrc

autoload -U promptinit
promptinit
prompt redhat # set redhat prompt. CHANGE when using custom prompt
# load colors
autoload -U colors
colors
# End of my configs

####################################
# Keybindings
####################################
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
# only past commands beginning with the current input are shown
[[ -n "${key[PageUp]}"       ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}"     ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# Use Ctrl-Left and Ctrl-Right as backward and forward word
# In xterm, Ctrl-Left outputs 5D and Ctrl-Right outputs 5C
bindkey ';5D' backward-word
bindkey ';5C' forward-word


# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
    printf '%s' "${terminfo[smkx]}"
  }
  function zle-line-finish () {
    printf '%s' "${terminfo[rmkx]}"
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi


##########################
# Functions
##########################
# man colors
man() {
      env \
          LESS_TERMCAP_mb=$(printf "\e[1;31m") \
          LESS_TERMCAP_md=$(printf "\e[1;31m") \
          LESS_TERMCAP_me=$(printf "\e[0m") \
          LESS_TERMCAP_se=$(printf "\e[0m") \
          LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
          LESS_TERMCAP_ue=$(printf "\e[0m") \
          LESS_TERMCAP_us=$(printf "\e[1;32m") \
              man "$@"
}
