# must be manually created
HISTFILE=~/.local/share/zsh/.histfile
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

setopt HIST_IGNORE_SPACE # Commands with a leading space are not added to history
setopt EXTENDED_HISTORY # Prefix each entry with ": <beginning time>:<elapsed seconds>;<command>"
setopt INC_APPEND_HISTORY # New history lines are added to the $HISTFILE incrementally (as soon as they are entered)
setopt NO_BEEP
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line being added to the history list
setopt HIST_IGNORE_DUPS # Do not enter command lines into the history list if they are duplicates of the previous event
setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

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


