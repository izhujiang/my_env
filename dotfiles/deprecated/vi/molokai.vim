" prefer the scheme to match the original monokai background color, otherwith comment it.
let g:rehash256 = 1
let g:molokai_original = 1

if has('nvim')
  if isdirectory(expand($HOME ."/.config/nvim/plugged/molokai"))
    colorscheme molokai
  endif
else
  if isdirectory(expand($HOME ."/.vim/plugged/molokai"))
    colorscheme molokai
  endif
endif
