" https://github.com/w0rp/ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_completion_enabled = 0
" When working with TypeScript files, ALE supports automatic imports from external modules.
let g:ale_completion_tsserver_autoimport = 0

" use the quickfix list instead of the loclist
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

" show Vim windows for the loclist or quickfix items when a file contains warnings or errors
let g:ale_open_list = 1
" keep the window open even after errors disappear.
" This can be useful if you are combining ALE with some other plugin which sets quickfix errors, etc.
" let g:ale_keep_list_window_open = 0

" Python
" https://blog.landscape.io/using-pylint-on-django-projects-with-pylint-django.html
" let g:ale_python_pylint_options = '--load-plugins pylint_django'

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" By default, all available tools for all supported languages will be run.
" you can define b:ale_linters for a single buffer, or g:ale_linters globally, if you want to only select a subset of the tools.
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'sh': ['shellcheck'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tsserver', 'tslint'],
      \ 'go': ['gofmt', 'golint', 'go vet'],
      \ 'python': ['flake8', 'pylint'],
      \ 'java': ['checkstyle', 'javac', 'google-java-format'],
      \ 'rust': ['cargo'],
      \ 'c': ['clang', 'clangd', 'cpplint'],
      \ 'cpp': ['clang', 'clangd', 'cpplint'],
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'scss': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['prettier'],
      \ 'python': ['autopep8', 'yapf'],
      \ 'c': ['clang-format', 'uncrustify'],
      \ 'cpp': ['clang-format', 'uncrustify'],
      \ }
" let g:ale_fixers = {'javascript': ['eslint',' prettier'] }
" let g:ale_fixers = {'javascript': ['standard']}


" Use these options to specify what text should be used for signs:
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Show 6 lines of errors (default: 10)
let g:ale_list_window_size = 6

" ALE sets some background colors automatically for warnings and errors in the sign gutter
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
"
" ALE's highlights problems with highlight groups which link to SpellBad, SpellCap, error, and todo groups by default.
" Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 0

" color scheme for ALE hightlights
" highlight ALEWarning ctermbg=DarkMagenta

"keep the sign gutter open at all times by setting the g:ale_sign_column_always to 1
" let g:ale_sign_column_always = 1

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" set statusline=%{LinterStatus()}


" There are 3 global options that allow customizing the echoed message.
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"
" ALE offers some commands with <Plug> keybinds for moving between warnings and errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" For more information, consult the online documentation with :help ale-navigation-commands.

" check JSX files with both stylelint and eslint
" First, install eslint and install stylelint with stylelint-processor-styled-components.
augroup JsxFiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" autocmd bufwritepost *.js silent !standard --fix %
" set autoread


" augroup YourGroup
"     autocmd!
"     autocmd User ALELintPre    call YourFunction()
"     autocmd User ALELintPost   call YourFunction()
"     autocmd User ALEJobStarted call YourFunction()
"     autocmd User ALEFixPre     call YourFunction()
"     autocmd User ALEFixPost    call YourFunction()
"   augroup END
