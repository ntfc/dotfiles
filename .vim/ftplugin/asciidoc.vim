setlocal autoindent
" replace Tab for spaces
setlocal expandtab
" wrap text longer than 80 characters
setlocal wrap
setlocal textwidth=80
" Add a column at the 81 character position
setlocal colorcolumn=+1
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
setlocal comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
setlocal spell spelllang=en_us
