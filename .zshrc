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
# rehash automatically
setopt nohashdirs
# load my aliases
source ~/.scripts/aliasrc
source ~/.scripts/gitaliasrc

autoload -U promptinit
promptinit
prompt redhat # set redhat prompt. CHANGE when using custom prompt
# load colors
autoload -U colors
colors

# Set the prompt
setopt prompt_subst
# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  ((git symbolic-ref -q HEAD | cut -d'/' -f3-) || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
parse_svn_branch() {
  if $(svn info >/dev/null 2>&1); then
    svn info | grep '^URL:' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$'
  fi
}
# If inside a Git or SVN repository, print its branch and state
vcs_prompt_string() {
  local git_where="$(parse_git_branch)"
  local svn_where="$(parse_svn_branch)"
  [ -n "$git_where" ] && echo "%{$fg_bold[blue]$bg[green]%}[$git_where]%{$reset_color%}"
  [ -n "$svn_where" ] && echo "%{$fg[blue]$bg[green]%}[$svn_where]%{$reset_color%}"
}

PROMPT="%{$fg[green]%}[%n@%m %1~]%{$reset_color%}%# "
# Set the right-hand prompt to the current branch
#RPROMPT='$(git_prompt_string)'
RPROMPT='$(vcs_prompt_string)'

####################################
# Keybindings
####################################
autoload zkbd
# https://wiki.archlinux.org/index.php/Zsh#Alternative_method_without_using_terminfo
[[ -f ~/.zkbd/rxvt-unicode-256color ]] && source ~/.zkbd/rxvt-unicode-256color

# vi mode
bindkey -v

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey  "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey  "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey  "${key[Insert]}"    overwrite-mode
[[ -n "${key[Delete]}"    ]] && bindkey  "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey  "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey  "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey  "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey  "${key[Right]}"     forward-char
# only past commands beginning with the current input are shown
[[ -n "${key[PageUp]}"    ]] && bindkey "${key[PageUp]}"     history-beginning-search-backward
[[ -n "${key[PageDown]}"  ]] && bindkey "${key[PageDown]}"   history-beginning-search-forward
[[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}"  backward-delete-char


# Use Ctrl-Left and Ctrl-Right as backward and forward word
# use 'cat > /dev/null' to discover key-definition
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# reverse search with Ctrl+R
bindkey '^R' history-incremental-search-backward


# remember the DIRSTACKSIZE last visited folders. Use dirs -v to print the
# dirstack, and use cd -NUM to cd to that folder
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

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

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2
