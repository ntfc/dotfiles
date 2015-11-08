# vim
## LaTeX
- Use [vim-latex](http://vim-latex.sourceforge.net/index.php)
- Recommended settings can be found [here](http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html)

### Tips
- If `set iskeyword+=:` is set, then if typing `\ref{fig:` and then <C-n> will cycle through all the figure labels
- <C-j> will jump to the next <++>
- use font mapping to insert bold, italic, etc
  * in insert mode, press `F` (for font) and then:
    - `BF` for bold
    - `EM` for emph
- in insert mode, use `S` and then:
  * `PA` for part
  * `CH` for `\chapter{}`
  * `SE` for `\section{}`
  * `SS` for `\subsection{}`
- `word<F7>` will create `\word{}`


## Misc
- Use `gq` to enforce linewidth on the current selection
- Use `j` to join multiple lines
