" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful
set iskeyword+=:

set complete+=kspell

let g:Tex_DefaultTargetFormat = 'pdf'

"http://vim-latex.sourceforge.net/documentation/latex-suite.html#Tex_MultipleCompileFormats
let g:Tex_MultipleCompileFormats='dvi,pdf'

let g:Tex_UseMakefile=1

" I don't like to execute zathura this way, because all stdout/stderr is dumped
" into vim.. So I use g:Tex_ViewRuleComplete_<format>. I could also use xdg-open
" instead of zathura, but well..
let g:Tex_ViewRule_dvi='zathura'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_ViewRule_ps ='zathura'
" http://vim-latex.sourceforge.net/documentation/latex-suite.html#Tex_ViewRuleComplete_format
let g:Tex_ViewRuleComplete_pdf='zathura $*.pdf &>/dev/null &'
let g:Tex_ViewRuleComplete_ps ='zathura $*.ps  &>/dev/null &'
let g:Tex_ViewRuleComplete_dvi='zathura $*.dvi &>/dev/null &'

