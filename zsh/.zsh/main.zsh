# The following lines were added by compinstall

zstyle ':completion:*' completer  _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle :compinstall filename '$HOME/.zsh/zshrc'

# vi mode
bindkey -v

# auto completion for command aliases
setopt completealiases

# command completion
autoload -Uz compinit
compinit
# End of lines added by compinstall

# rehash automatically
setopt nohashdirs

# load my aliases
[ -f ~/.config/alias/aliasrc ] && source ~/.config/alias/aliasrc
[ -f ~/.config/alias/gitaliasrc ] && source ~/.config/alias/gitaliasrc

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

## If not running interactively, do not do anything
#[[ $- != *i* ]] && return
#[[ hash tmux 2>/dev/null && -z "$TMUX" ]] && exec tmux -2
