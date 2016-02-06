if exists(":NERDTree")
  " maps NERDTree to F10
  noremap <silent> <F10> :NERDTreeToggle<CR>
  noremap! <silent> <F10> <ESC>:NERDTreeToggle<CR>
  " tells NERDTree to use ASCII chars
  let g:NERDTreeDirArrows=0
  " How can I close vim if the only window left open is a NERDTree?
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

