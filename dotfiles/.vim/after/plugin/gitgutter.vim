" turn off realtime updates
" .vim/after/plugin/gitgutter.vim
if exists('#gitgutter')
  " turn off realtime updates
  autocmd! gitgutter CursorHold,CursorHoldI
  " update signs when saving a file
  autocmd BufWritePost * GitGutter
endif
