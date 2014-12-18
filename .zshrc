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

# Set the prompt
setopt prompt_subst
# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  ((git symbolic-ref -q HEAD | cut -d'/' -f3) || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "%{$fg[blue]%}[$git_where]%{$reset_color%}"
}

PROMPT="%{$fg[green]%}[%n@%m %1~] %{$reset_color%}%# "
# Set the right-hand prompt to the current branch
RPROMPT='$(git_prompt_string)'

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
# use 'cat > /dev/null' to discover key-definition
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# reverse search with Ctrl+R
bindkey '^R' history-incremental-search-backward

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

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
