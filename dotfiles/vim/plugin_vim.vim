" don't override built-in mark
let g:bookmark_no_default_key_mappings = 1
nnoremap <Leader>mm <Plug>BookmarkToggle
nnoremap <Leader>mi <Plug>BookmarkAnnotate
nnoremap <Leader>ma <Plug>BookmarkShowAll
nnoremap <Leader>mj <Plug>BookmarkNext
nnoremap <Leader>mk <Plug>BookmarkPrev
nnoremap <Leader>mc <Plug>BookmarkClear
nnoremap <Leader>mx <Plug>BookmarkClearAll

"------------------------------------------------------------------------------
" YouCompleteMe

" let g:ycm_auto_trigger = 1
" let g:ycm_disable_signature_help = 0
" let g:ycm_use_ultisnips_completer = 1
" let g:ycm_cache_omnifunc = 1

" semantic suggestion will override UltiSnips and identifier suggestion,
" don't trigger semantic suggestion until more then 3+ characters('re!/w{4}).
let g:ycm_semantic_triggers = {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'java,python,scala,go' : ['.', 're!\w{4}'],
  \   'javascript,jsx,javascript.jsx,typescript,typescript,tsx' : ['.', 're!\w{4}'],
  \   'cs,d,perl6,vb,elixir' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \   'sh,bash' : ['re!\w{2}'],
  \   'mail': [
  \     're!^Bcc:(.*, ?| ?)',
  \     're!^Cc:(.*, ?| ?)',
  \     're!^From:(.*, ?| ?)',
  \     're!^Reply-To:(.*, ?| ?)',
  \     're!^To:(.*, ?| ?)'
  \   ],
  \   'markdown': [
  \     ']('
  \   ]
  \ }

" turn on YCM.
let g:ycm_filetype_whitelist = {
  \ '*': 1,
  \ 'ycm_nofiletype': 1
  \ }

" turn off YCM.  Same as default, but with 'mail', 'markdown' and 'text' removed.
let g:ycm_filetype_blacklist = {
  \   'notes': 1,
  \   'unite': 1,
  \   'tagbar': 1,
  \   'pandoc': 1,
  \   'qf': 1,
  \   'vimwiki': 1,
  \   'infolog': 1,
  \ }

  " Disable semantic completion engine.
let g:ycm_filetype_specific_completion_to_disable = {
    \   'gitcommit': 1,
    \   'haskell': 1,
    \   'ruby': 1,
    \ }

  " let g:ycm_filepath_completion_use_working_dir = 0
  let g:ycm_filepath_blacklist = {
    \ 'html' : 1,
    \ 'jsx' : 1,
    \ 'xml' : 1,
    \ }

" let g:ycm_disable_for_files_larger_than_kb = 1000
" let g:ycm_min_num_of_chars_for_completion = 2
" let g:ycm_min_num_identifier_candidate_chars = 0
" let g:ycm_max_num_identifier_candidates = 10
" let g:ycm_max_num_candidates = 50
" let g:ycm_max_num_candidates_to_detail = 0

let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1


" turns off YCM's diagnostic display features, which override ale's dianostics
let g:ycm_show_diagnostics_ui = 0
let g:ycm_max_diagnostics_to_display = 30

" let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_error_symbol = '*>'
" let g:ycm_warning_symbol = '>>'

" let g:ycm_echo_current_diagnostic = 1
let g:ycm_update_diagnostics_in_insert_mode = 0
let g:ycm_always_populate_location_list = 0

" DON'T use filter which cause error in mousemove event
" let g:ycm_filter_diagnostics = {
"    \ 'java': {
"        \ 'regex': [ 'ta.+co', '*'],
"        \ 'level': 'error',
"        \ },
"    \ }
let g:ycm_auto_hover=''
let g:ycm_show_detailed_diag_in_popup = 0

" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_enable_semantic_highlighting = 1
let MY_YCM_HIGHLIGHT_GROUP = {
      \   'typeParameter': 'PreProc',
      \   'parameter': 'Normal',
      \   'variable': 'Normal',
      \   'property': 'Normal',
      \   'enumMember': 'Normal',
      \   'event': 'Special',
      \   'member': 'Normal',
      \   'method': 'Normal',
      \   'class': 'Special',
      \   'namespace': 'Special',
      \ }
if ! has('nvim')
  for tokenType in keys( MY_YCM_HIGHLIGHT_GROUP )
    call prop_type_add( 'YCM_HL_' . tokenType,
                    \ { 'highlight': MY_YCM_HIGHLIGHT_GROUP[ tokenType ] } )
  endfor
endif

let g:ycm_enable_inlay_hints = 0
let g:ycm_clear_inlay_hints_in_insert_mode = 1


let g:ycm_goto_buffer_command = 'same-buffer'
" let g:ycm_open_loclist_on_ycm_diags = 1


" Normally, YCM searches for a .ycm_extra_conf.py file for compilation flags.
" YCM looks for a .ycm_extra_conf.py file in current directory or parent directories(recursively, till ${HOME}) 
" and loads it (only once!) as a Python module.
" let g:ycm_extra_conf_globlist = []
" ycm_global_ycm_extra_conf specifies a fallback path to a config file which is used if no .ycm_extra_conf.py is found.
let g:ycm_global_ycm_extra_conf = expand($VI_HOME ."/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py")
let g:ycm_confirm_extra_conf = 0

" C-family Semantic Completion
" let g:ycm_use_clangd = 1
" let g:ycm_clangd_binary_path = 'clangd'
" let g:ycm_clangd_args = []
" let g:ycm_clangd_uses_ycmd_caching = 1

" NOTE: It is highly recommended to include -x <language> flag to libclang.
" This is so that the correct language is detected, particularly for header files.
" Common values are -x c for C, -x c++ for C++, -x objc for Objective-C, and -x cuda for CUDA.
" Ref: using YCM-Generator (https://github.com/rdnetto/YCM-Generator) to generate the ycm_extra_conf.py file.

" golang Semantic Completion
let g:ycm_gopls_binary_path = 'gopls'
" let g:ycm_gopls_args = []


" javascript and Typescript  Semantic Completion
" let g:ycm_tsserver_binary_path = 'path of tsserver executable'


" JAVA Semantic Completion
" conflict with other dianostics plugins like Syntastic and other dianostics plugins like Eclim
let g:syntastic_java_checkers = []
let g:EclimFileTypeValidate = 0

" Python Semantic Completion
" DO NOT set g:ycm_server_python_interpreter. Actually, ycmd only run with the python that build it.
" let g:ycm_server_python_interpreter = ''
" YCM will use the first python executable it finds in the PATH to run jedi. 
" This means that if you are in a virtual environment and you start vim in that directory,
" the first python that YCM will find will be the one in the virtual environment,
" NOTE: This interpreter is only used for the ycmd server. 
" The YCM client running inside Vim always uses the Python interpreter that's embedded inside Vim.

" OmniSharp-Roslyn server
" let g:ycm_auto_start_csharp_server = 1
" let g:ycm_auto_stop_csharp_server = 1
" let g:ycm_csharp_server_port = 0
" let g:ycm_csharp_insert_namespace_expr = ''
" let g:ycm_roslyn_binary_path = 'path of Omnisharp-Roslyn executable'


" support language servers used with YCM
  " TODO: bash-language-server not working in YouCompleteMe
  " \   {
  " \     'name': 'bash',
  " \     'cmdline': [ 'bash-language-server', 'start' ],
  " \     'filetypes': [ 'sh', 'bash' ],
  " \   },
let g:ycm_language_server = [
  \   {
  \     'name': 'json',
  \     'cmdline': [ 'typescript-language-server', '--stdio' ],
  \     'filetypes': [ 'json' ],
  \   },
  \   { 'name': 'docker',
  \     'filetypes': [ 'dockerfile' ],
  \     'cmdline': [ 'docker-langserver', '--stdio' ]
  \   },
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ 'vim-language-server', '--stdio' ]
  \   },
  \   { 'name': 'lua',
  \     'filetypes': [ 'lua' ],
  \     'cmdline': ['lua-language-server'],
  \     'capabilities': { 'textDocument': { 'completion': { 'completionItem': { 'snippetSupport': v:true } } } },
  \     'triggerCharacters': []
  \   },
  \ ]

" YCM and the ycmd completion server will keep the logfiles around after shutting down
" let g:ycm_keep_logfiles = 0
" let g:ycm_log_level = 'info'
" let g:ycm_log_level = 'debug'


" Trigger semantic completion anywhere. Useful for searching for top-level functions and classes (C++, java)
let g:ycm_key_invoke_completion = '<C-.>'

" TODO: overrid built-in K function. Run a program (keywordprg) to lookup the keyword under the cursor.
nnoremap <silent> K <plug>(YCMHover)
" Show detailed diagnostics
let g:ycm_key_detailed_diagnostics = '<Leader>yd'

nnoremap gd :YcmCompleter GoTo<CR>
nnoremap <leader>yc :YcmCompleter GoToCallers<CR>
nnoremap <leader>ye :YcmCompleter GoToCallees<CR>

" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

nnoremap  <leader>ys <Plug>(YCMFindSymbolInWorkspace)
nnoremap  <leader>yf <Plug>(YCMFindSymbolInDocument)

nnoremap  <leader>yy  :YcmCompleter FixIt<CR>

" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" let g:ycm_key_list_stop_completion = ['<C-y>']
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<enter>']
" avoid to use <enter>, which is confix with enter next line
"
" <c-n> is bind to tab again by SuperTab, which walk around the confix with UltiSnips
let g:SuperTabDefaultCompletionType = '<C-n>'

"  don't use inoremap <expr> <CR>, which will disable <CR> to enter next line
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" hide/show the signature help popup
inoremap <silent> <C-l> <Plug>(YCMToggleSignatureHelp)

" Customize Quickfix and Location Window
" autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()
" autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

" Errors during compilation
" Call the :YcmDiags command to see if any errors or warnings were detected in your file.
"
" Ycmd Commands
" :YcmRestartServer
" :YcmDebugInfo
" :YcmToggleLogs
"
" :YcmDiags
" :YcmShowDetailedDiagnostic
"
" This command offers IDE-like features in YCM: semantic GoTo, type information, FixIt and refactoring.
" :YcmCompleter [command]
" ------------------------------------------------------------------------------
" misc
" -----------------------------------------------------------------------------
" vim-session (session management)
" let g:session_directory = "~/.session"
" let g:session_autoload = "no"
" let g:session_autosave = "no"
" let g:session_command_aliases = 1

" set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages,slash,unix

" " Remember things between sessions
" " '20  - remember marks for 20 previous files
" " \"50 - save 50 lines for each register
" " :20  - remember 20 items in command-line history
" " /20  - remember 20 items in search history
" " %    - remember the buffer list (if vim started without a file arg)
" " n    - set name of viminfo file
" " set viminfo='20,\"50,:20,/20,%,n~/.viminfo

" " Remember info about open buffers on close
" " set viminfo^=%