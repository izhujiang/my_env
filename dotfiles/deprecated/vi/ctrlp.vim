" -----CTRLP-------------------------------------------
" make Ctrl-p use ripgrep as its file finding engine.
" riggrep with a command named rg.
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class|jar|war)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
