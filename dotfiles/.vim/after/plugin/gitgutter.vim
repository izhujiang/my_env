" turn off realtime updates
" .vim/after/plugin/gitgutter.vim
"
autocmd! gitgutter CursorHold,CursorHoldI
autocmd BufWritePost * GitGutter
