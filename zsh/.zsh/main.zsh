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

# fish-like suggestions https://github.com/zsh-users/zsh-autosuggestions/
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# command completion
autoload -Uz compinit
compinit
# https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders/308322
_comp_options+=(globdots)
# End of lines added by compinstall

# rehash automatically
setopt nohashdirs

# load my aliases
[ -f ~/.aliasrc ] && source ~/.aliasrc
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
