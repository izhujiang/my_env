" emmet settings
" Enable just for html/css/javascript/typescript
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,typescript EmmetInstall

" defautl emmet leader key is <c-y>
" let g:user_emmet_leader_key='<c-j>'
let g:user_emmet_leader_key=','

let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}

" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
