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
# show the git remote name
parse_git_remote_name() {
  (git remote -v | head -n1 | awk '{print $2}' | sed -e 's,.*:\(.*/\)\?,,' -e 's/\.git$//') 2> /dev/null
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
  local git_name="$(parse_git_remote_name)"
  local _full_prompt=""
  [ -n "$svn_where" ] && _full_prompt="${_full_prompt}%{$fg[blue]$bg[green]%}[$svn_where]%{$reset_color%}"
  [ -n "$git_where" ] && _full_prompt="${_full_prompt}%{$fg_bold[blue]%}$git_where%{$reset_color%} @ %{$fg_bold[red]%}$git_name%{$reset_color%}"
  echo "${_full_prompt}"
}

# set VIMODE according to the current mode (default “[i]”). VIMODE can be used on the PROMPT
VIMODE='[i]'
function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/[n]}/(main|viins)/[i]}"
  zle reset-prompt
}
zle -N zle-keymap-select

PROMPT="%{$fg[green]%}[%n@%m %1~]%{$reset_color%}%# "
# Set the right-hand prompt to the current branch
RPROMPT='${VIMODE} $(vcs_prompt_string)'


