" -------Java
" options ref to https://github.com/sbdchd/neoformat
autocmd BufNewFile,BufReadPost *.java
    \ let g:neoformat_enabled_java = ['uncrustify', 'astyle']
    " configure Neomake to open the list automatically:
    \ let g:neomake_open_list = 2

    " vim-rooter change current directory where build.gradle exists.
" and vim-gradle run make command(make build/run/test)
    \ let g:rooter_targets = '*.gradle,*.java,*.yml,*.yaml'
    \ let g:rooter_patterns = ['settings.gradle', 'build.gradle', '.git', '.git/']

" run a formatter on save
augroup fmt
  autocmd!
  autocmd BufWritePre *.java undojoin | Neoformat
" autocmd BufWritePre * undojoin | Neoformat
augroup END
