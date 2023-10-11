let g:grepper = {}
" using <Tab> to switch grep programm, :Grepper<Tab>
let g:grepper.tools = ['rg', 'git', 'grep']

" search for current word
nnoremap <leader>* :Grepper -cword -noprompt<CR>
" search for current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" set grepprg=rg\ -H\ --no-heading\ --vimgrep
" set grepformat=$f:$l:$:%c:%m
