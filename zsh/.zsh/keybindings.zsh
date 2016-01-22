####################################
# Keybindings
####################################
autoload zkbd
# https://wiki.archlinux.org/index.php/Zsh#Alternative_method_without_using_terminfo
[[ -f ~/.zkbd/rxvt-unicode-256color ]] && source ~/.zkbd/rxvt-unicode-256color

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
bindkey '^[[1~'   beginning-of-line # home
bindkey '^[[2~'   overwrite-mode # insert
bindkey '^[[3~'   delete-char # del
bindkey '^[[4~'   end-of-line # end
bindkey '^[[5~'   history-beginning-search-backward # page up
bindkey '^[[6~'   history-beginning-search-forward # page down
bindkey '^[[7~'   beginning-of-line # home
bindkey '^[[8~'   end-of-line # end

# reverse search with Ctrl+R
bindkey '^R' history-incremental-search-backward


