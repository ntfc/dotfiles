HISTFILE=~/.local/share/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory
unsetopt beep

# https://shapeshed.com/zsh-corrupt-history-file/
function zsh_history_fix() {
  mv ${HISTFILE} ${HISTFILE}.bad
  strings ${HISTFILE}.bad > ${HISTFILE}
  fc -R ${HISTFILE}
  rm ${HISTFILE}.bad
}

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

