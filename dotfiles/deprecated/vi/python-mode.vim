augroup vim-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  " autocmd BufNewFile,BufRead *.py
    " \ set textwidth=79 |
    " expandtab turns <TAB>s into spaces.
    " \ set expandtab |
    " \ set foldmethod=indent |  " fold based on indent level
    " \ set fileformat=unix
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python nnoremap <F5> :!python %<CR>
"    autocmd FileType python nnoremap <leader>r :!python %<CR>
"    autocmd FileType python nnoremap <localleader>r :!python %<CR>
augroup END

" 2.common functionality.......................................|pymode-common|
    " let g:pymode = 1
    " let g:pymode_warnings = 1
    " let g:pymode_paths = []
    " let g:pymode_trim_whitespaces = 1

    " let g:pymode_options = 1
        " setlocal complete+=t
        " setlocal formatoptions-=t
        " if v:version > 702 && !&relativenumber
        "     setlocal number
        " endif
        " setlocal nowrap
        " setlocal textwidth=79
        " setlocal commentstring=#%s
        " setlocal define=^\s*\\(def\\\\|class\\)

        " let g:pymode_options_max_line_length = 79
        " let g:pymode_options_colorcolumn = 1
        " let g:pymode_quickfix_minheight = 3
        " let g:pymode_quickfix_maxheight = 6

"     2.1 python version...............................|pymode-python-version|
        " By default python-mode uses python 2 syntax checking. To enable python 3 syntax checking
        let g:pymode_python = 'python'
        " let g:pymode_python = 'python3'

"     2.2 python indentation...................................|pymode-indent|
        " let g:pymode_indent = 1

"     2.3 python folding......................................|pymode-folding|
        let g:pymode_folding = 0  " SimplyFold
"     2.4 vim motion...........................................|pymode-motion|
        " let g:pymode_motion = 1
        " support vim motion (see |operator|) for python objects (such as functions, " class and methods).
        " `c` — means class
        " `m` — means method or function
        "                                                             *pymode-motion-keys*
        " ================  ============================
        " key               command
        " ================  ============================
        " [[                jump to previous class or function (normal, visual, operator modes)
        " ]]                jump to next class or function  (normal, visual, operator modes)
        " [m                jump to previous class or method (normal, visual, operator modes)
        " ]m                jump to next class or method (normal, visual, operator modes)
        " ac                select a class. ex: vac, dac, yac, cac (normal, operator modes)
        " ic                select inner class. ex: vic, dic, yic, cic (normal, operator modes)
        " am                select a function or method. ex: vam, dam, yam, cam (normal, operator modes)
        " im                select inner function or method. ex: vim, dim, yim, cim (normal, operator modes)
        " ================  ============================

"     2.5 show documentation............................|pymode-documentation|
        " let g:pymode_doc = 1
        " *:PymodeDoc* <args> — show documentation

        " let g:pymode_doc_bind = 'K'
        " Bind keys to show documentation for current word (selection)

"     2.6 support virtualenv...............................|pymode-virtualenv|
        "Enable automatic virtualenv detection
        " let g:pymode_virtualenv = 1

"     2.7 run code................................................|pymode-run|
        " *:PymodeRun* -- Run current buffer or selection
        " let g:pymode_run = 1
        " let g:pymode_run_bind = '<leader>r'
"
"     2.8 breakpoints.....................................|pymode-breakpoints|
        " Pymode automatically detects available debugger (like pdb, ipdb, pudb)
        " let g:pymode_breakpoint = 1
        " let g:pymode_breakpoint_bind = '<leader>b'
        " let g:pymode_breakpoint_cmd = ''

" 3. code checking...............................................|pymode-lint|
"     3.1 code checkers options..........................|pymode-lint-options|
"     using ale (Asynchronous Lint Engine) instead.
    let g:pymode_lint = 0
" 4. rope support................................................|pymode-rope|
    let g:pymode_rope = 0
"     4.1 code completion..................................|pymode-completion|
"     4.2 find definition.................................|pymode-rope-findit|
"     4.3 refactoring................................|pymode-rope-refactoring|
"     4.4 undo/redo changes.................................|pymode-rope-undo|
" 5. syntax....................................................|pymode-syntax|
    " let g:pymode_syntax = 1
    let g:pymode_syntax_slow_sync = 0

    " let g:pymode_syntax_all = 1
    " let g:pymode_syntax_print_as_function = 0
    " let g:pymode_syntax_highlight_async_await = g:pymode_syntax_all
    " let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
    " let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
    " let g:pymode_syntax_highlight_self = g:pymode_syntax_all
    " let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    " let g:pymode_syntax_space_errors = g:pymode_syntax_all
    " let g:pymode_syntax_string_formatting = g:pymode_syntax_all
    " let g:pymode_syntax_string_format = g:pymode_syntax_all
    " let g:pymode_syntax_string_templates = g:pymode_syntax_all
    " let g:pymode_syntax_doctests = g:pymode_syntax_all
    " let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
    " let g:pymode_syntax_builtin_types = g:pymode_syntax_all
    " let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
    " let g:pymode_syntax_docstrings = g:pymode_syntax_all
