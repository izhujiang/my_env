" To prevent the execution of malicious code from a file you didn't write,
" YCM will ask you once per .ycm_extra_conf.py if it is safe to load.
let g:ycm_confirm_extra_conf = 0 "关闭加载.ycm_extra_conf.py提示

" Normally, YCM searches for a .ycm_extra_conf.py file for compilation flags (see the User Guide for more details on how this works).
"
" YCM looks for a .ycm_extra_conf.py file in the directory of the opened file or in any directory above it in the hierarchy (recursively);
" when the file is found, it is loaded (only once!) as a Python module.
" YCM calls a Settings method in that module which should provide it with the information necessary to compile the current file.
"
" NOTE: It is highly recommended to include -x <language> flag to libclang.
" This is so that the correct language is detected, particularly for header files.
" Common values are -x c for C, -x c++ for C++, -x objc for Objective-C, and -x cuda for CUDA.
"
" This option specifies a fallback path to a config file which is used if no .ycm_extra_conf.py is found.
" let g:ycm_global_ycm_extra_conf = ''
if has('nvim')
  let g:ycm_global_ycm_extra_conf = expand($HOME ."/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py")
  let s:lsp = expand($HOME ."/.config/nvim/plugged/ycmd-lsp")
else
  let g:ycm_global_ycm_extra_conf = expand($HOME ."/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py")
  let s:lsp = expand($HOME ."/.vim/plugged/ycmd-lsp")
endif
if filereadable(expand($HOME ."/.ycm_extra_conf.py"))
  let g:ycm_global_ycm_extra_conf = expand($HOME ."/.ycm_extra_conf.py")
endif

" YCM will by default search for an appropriate Python interpreter on your system.
" You can use this option to override that behavior and force the use of a specific interpreter of your choosing.
" DO NOT set g:ycm_server_python_interpreter. Actually, ycmd only run with the python that build it.
" (python3 ./install.py --clangd-completer --go-completer --ts-completer --rust-completer)
"
" NOTE: This interpreter is only used for the ycmd server.
" The YCM client running inside Vim always uses the Python interpreter that's embedded inside Vim.
" let g:ycm_server_python_interpreter = ''

" enable for debug
" let g:ycm_log_level = 'debug'

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'

let g:ycm_min_num_of_chars_for_completion = 1    " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc = 0    " 禁止缓存匹配项,每次都重新生成匹配项

let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
" let g:ycm_collect_identifiers_from_tags_files = 0 " it makes vim slower if the tags on a network directory

let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword

let g:ycm_auto_trigger = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_echo_current_diagnostic = 1
let g:ycm_open_loclist_on_ycm_diags = 1


let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_max_diagnostics_to_display = 30

" [ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab', 'new-or-existing-tab']
let g:ycm_goto_buffer_command = 'same-buffer'

" By default, YCM will query the UltiSnips plugin for possible completions of snippet triggers. This option can turn that behavior off.
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure


" If you work on a Python 3 project, you may need to set g:ycm_python_binary_path to the Python interpreter
" you use for your project to get completions for that version of Python.
" YCM will use the first python executable it finds in the PATH to run jedi. This means that if you are in a virtual environment
" and you start vim in that directory, the first python that YCM will find will be the one in the virtual environment,
" so jedi will be able to provide completions for every package you have in the virtual environment.
let g:ycm_python_binary_path = 'python3'

" conflict with other dianostics plugins like Syntastic and other dianostics plugins like Eclim
let g:syntastic_java_checkers = []
let g:EclimFileTypeValidate = 0

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif

" semantic suggestion will override UltiSnips snippet suggestion, so don't trigger util more then 3 characters('re!/w{4}).
let g:ycm_semantic_triggers = {
    \   'c' : ['->', '.'],
    \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
    \   'ocaml' : ['.', '#'],
    \   'cpp,objcpp' : ['->', '.', '::'],
    \   'perl' : ['->'],
    \   'php' : ['->', '::'],
    \   'java,python,scala,go' : ['.', 're!\w{2}'],
    \   'javascript,jsx,javascript.jsx,typescript,typescript,tsx' : ['.', 're!\w{2}'],
    \   'cs,d,perl6,vb,elixir' : ['.'],
    \   'ruby' : ['.', '::'],
    \   'lua' : ['.', ':'],
    \   'erlang' : [':'],
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

let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "java":1,
			\ "groovy":1,
			\ "scala":1,
      \ "js":1,
			\ "javascript":1,
      \ 'jsx':1,
			\ "typescript":1,
			\ "python":1,
			\ "go":1,
			\ "ruby":1,
			\ "perl":1,
			\ "php":1,
			\ "vim":1,
			\ "xml":1
			\ }

" Same as default, but with "mail", "markdown" and "text" removed.
let g:ycm_filetype_blacklist = {
    \   'notes': 1,
    \   'unite': 1,
    \   'tagbar': 1,
    \   'pandoc': 1,
    \   'qf': 1,
    \   'vimwiki': 1,
    \   'infolog': 1,
    \   'mail' : 1,
    \   'markdown' : 1,
    \   'text' : 1,
    \ }

let g:ycm_filepath_blacklist = {
    \ 'html' : 1,
    \ 'jsx' : 1,
    \ 'xml' : 1,
    \}

" Disable unhelpful semantic completions.
let g:ycm_filetype_specific_completion_to_disable = {
    \   'gitcommit': 1,
    \   'haskell': 1,
    \   'ruby': 1,
    \ }

let g:ycm_filter_diagnostics = {}
" \ "java": {
" \      "regex": [ ".*taco.*", ... ],
" \      "level": "error",
" \    }
" \ }

" ---YCM--------------
"  don't use inoremap <expr> <CR>, which will disable <CR> to enter next line
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"


" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" let g:ycm_key_list_stop_completion = ['<C-y>']

let g:ycm_key_invoke_completion = '<C-,>'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>',  '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>', '<Up>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<enter>']
" avoid to use <enter>, which is confix with enter next line
" let g:ycm_key_list_stop_completion = ['<enter>']
" <c-n> is bind to tab again by SuperTab, which walk around the confix with UltiSnips
let g:SuperTabDefaultCompletionType = '<C-n>'
" let g:SuperTabCrMapping = 0
" This option controls the key mapping used to show the full diagnostic text when the user's cursor is on the line with the diagnostic. Default: <leader>d
" let g:ycm_key_detailed_diagnostics = '<leader>d'

nnoremap <leader>g :YcmCompleter GoTo<CR> " 跳转到定义处
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>    "force recomile with syntastic
nnoremap  <F4> :YcmDiags<CR>

autocmd InsertLeave * if pumvisible() != 0|pclose|endif    "离开插入模式后自动关闭预览窗口

" support language servers used with YCM
let g:ycm_language_server = [
  \   {
  \     'name': 'bash',
  \     'cmdline': [ 'node', expand( s:lsp . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
  \     'filetypes': [ 'sh', 'bash' ],
  \   },
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ 'node', expand( s:lsp . '/yaml/node_modules/.bin/yaml-language-server' ), '--stdio' ],
  \     'filetypes': [ 'yaml' ],
  \   },
  \   {
  \     'name': 'json',
  \     'cmdline': [ 'node', expand( s:lsp . '/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
  \     'filetypes': [ 'json' ],
  \   },
  \   { 'name': 'docker',
  \     'filetypes': [ 'dockerfile' ],
  \     'cmdline': [ expand( s:lsp . '/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
  \   },
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ expand( s:lsp . '/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
  \   },
  \ ]
  " \   { 'name': 'rust',
  " \     'filetypes': [ 'rust' ],
  " \     'cmdline': [ expand( s:lsp .  '/rust/rust-analyzer/target/release/rust-analyzer' ) ],
  " \     'project_root_files': [ 'Cargo.toml' ],
  " \   },
  "
  " \   {
  " \     'name': 'php',
  " \     'cmdline': [ 'php', expand( s:lsp . '/php/vendor/bin/php-language-server.php' ) ],
  " \     'filetypes': [ 'php' ],
  " \   },
  " \   {
  " \     'name': 'dart',
  " \     'cmdline': [ 'dart', expand( s:lsp . '/dart/analysis_server.dart.snapshot' ), '--lsp' ],
  " \     'filetypes': [ 'dart' ],
  " \   },
  " \   { 'name': 'scala',
  " \     'filetypes': [ 'scala' ],
  " \     'cmdline': [ 'metals-vim' ],
  " \     'project_root_files': [ 'build.sbt' ]
  " \   },
  " \   { 'name': 'purescript',
  " \     'filetypes': [ 'purescript' ],
  " \     'cmdline': [ expand( s:lsp . '/viml/node_modules/.bin/purescript-language-server' ), '--stdio' ]
  " \   },
  " \   { 'name': 'fortran',
  " \     'filetypes': [ 'fortran' ],
  " \     'cmdline': [ 'fortls' ],
  " \   },
  " \   { 'name': 'haskell',
  " \     'filetypes': [ 'haskell', 'hs', 'lhs' ],
  " \     'cmdline': [ 'hie-wrapper', '--lsp' ],
  " \     'project_root_files': [ '.stack.yaml', 'cabal.config', 'package.yaml' ]
  " \   },
  " \   { 'name': 'julia',
  " \     'filetypes': [ 'julia' ],
  " \     'project_root_files': [ 'Project.toml' ],
  " \     'cmdline': <See note below>
  " \   },
  " \   { 'name': 'lua',
  " \     'filetypes': [ 'lua' ],
  " \     'cmdline': [ expand( s:lsp . '/lua/lua-language-server/root/extension/server/bin/macOS/lua-language-server'),
  " \                  expand( s:lsp . '/lua/lua-language-server/root/extension/server/main.lua' ) ]
  " \   },
  " \   {
  " \     'name': 'ruby',
  " \     'cmdline': [ expand( s:lsp . '/ruby/bin/solargraph' ), 'stdio' ],
  " \     'filetypes': [ 'ruby' ],
  " \   },
  " \   { 'name': 'kotlin',
  " \     'filetypes': [ 'kotlin' ],
  " \     'cmdline': [ expand( s:lsp . '/kotlin/server/build/install/server/bin/server' ) ],
  " \   },
  " \   { 'name': 'd',
  " \     'filetypes': [ 'd' ],
  " \     'cmdline': [ expand( s:lsp . '/d/serve-d' ) ],
  " \   },
  " \   { 'name': 'vue',
  " \     'filetypes': [ 'vue' ],
  " \     'cmdline': [ expand( s:lsp . '/vue/node_modules/.bin/vls' ) ]
  " \   },
