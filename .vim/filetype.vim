" Determine the "type" of a file.
" http://vim.wikia.com/wiki/Filetype.vim
au BufRead,BufNewFile *.coffee setlocal ft=coffee
au BufRead,BufNewFile *.json setlocal ft=json
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
