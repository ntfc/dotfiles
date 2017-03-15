####################################
# Keybindings
####################################

# from https://askubuntu.com/questions/476641/how-can-i-get-the-name-of-the-current-terminal-from-command-line
which_term(){
  term=$(ps -p $(ps -p $$ -o ppid=) -o args=)
  found=0
  case $term in
    *rxvt*)
      found=1
      echo "rxvt"
      ;;
    xterm*)
      found=1
      echo "xterm"
      ;;
    tmux*)
      found=1
      echo "tmux"
      ;;
    *)
      ;;
  esac
}

autoload zkbd

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

# use Ctrl+Backspace to remove words
function remove_word() {
  # use a different WORDCHARS for this command
  WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' zle backward-kill-word
}
# register new keymap function
zle -N _backward-kill-word remove_word

# rxvt specific configurations
case which_term in
  # rxvt specific configurations
  rxvt)
    # https://wiki.archlinux.org/index.php/Zsh#Alternative_method_without_using_terminfo
    [[ -f ~/.zkbd/rxvt-unicode-256color ]] && source ~/.zkbd/rxvt-unicode-256color

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
    bindkey '^H' _backward-kill-word

    # press Ctrl+Q to put current command on queue, execute another command, and
    # the first command comes back
    # see http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
    # access to C^Q: https://github.com/thoughtbot/dotfiles/commit/a1a9f6d6947791d7b2c9a216aa56a5a12cc39c51
    stty -ixon
    bindkey "^Q" push-line-or-edit
    ;;
  # xterm specific configurations
  xterm)
    # Use Ctrl-Left and Ctrl-Right as backward and forward word
    # use 'cat > /dev/null' to discover key-definition
    bindkey '^[[1;5D' backward-word
    bindkey '^[[1;5C' forward-word
    bindkey '^[[H'    beginning-of-line # home
    bindkey '^[[2~'   overwrite-mode # insert
    bindkey '^[[3~'   delete-char # del
    bindkey '^[[F'    end-of-line # end
    bindkey '^[[5~'   history-beginning-search-backward # page up
    bindkey '^[[6~'   history-beginning-search-forward # page down

    # reverse search with Ctrl+R
    bindkey '^R' history-incremental-search-backward
    bindkey '^?' _backward-kill-word

    # press Ctrl+Q to put current command on queue, execute another command, and
    # the first command comes back
    # see http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
    # access to C^Q: https://github.com/thoughtbot/dotfiles/commit/a1a9f6d6947791d7b2c9a216aa56a5a12cc39c51
    stty -ixon
    bindkey "^Q" push-line-or-edit
    ;;
esac
