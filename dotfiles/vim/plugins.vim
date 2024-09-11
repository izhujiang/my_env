" *****************************************************************************
" Vim-PLug 
" ****************************************************************************
let vimplug_exists=expand(g:vim_home . '/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" ****************************************************************************
" Try load plugins lazily as possible
call plug#begin(g:vim_home . '/plugged')
  " colorscheme
  " Plug 'altercation/vim-colors-solarized'
  Plug 'morhetz/gruvbox'

  " Status/tabline for vim
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Universal CTags: tagging engine that scans project files and generates tag files.
  " Tagbar: displays a window with a hierarchical list of tags in the current file.
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

  " Grepper plugin run grep-like tools(ag, ack, git grep, ripgrep) asynchronously.
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', 'GrepperGrep', 'GrepperRg', 'GrepperGit', '<plug>(GrepperOperator)'] }
  " fzf, Fuzzy finder: file, buffer, mru, tag, etc. asynchronous and fast (vs. CtrlP)
  if isdirectory('/usr/local/opt/fzf')
    set rtp+=/usr/local/opt/fzf
    Plug '/usr/local/opt/fzf', { 'do': { -> fzf#install() } }
  elseif isdirectory('/opt/homebrew/opt/fzf')
    set rtp+=/opt/homebrew/opt/fzf
    Plug '/opt/homebrew/opt/fzf', { 'do': { -> fzf#install() } }
  elseif isdirectory('/home/linuxbrew/.linuxbrew/opt/fzf')
    set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
    Plug '/home/linuxbrew/.linuxbrew/opt/fzf', { 'do': { -> fzf#install() } }
  else
    set rtp+=~/.fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  endif
  Plug 'junegunn/fzf.vim'

  " a suite consist of supertab, YouCompleteMe and ultisnips
  " DON'T use Supertab, which change the default behaviour of <Tab> key, use <Tab> to fullfil the insert completion needs.
  " Plug 'ervandew/supertab'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  " Build YouCompleteMe, info = {name, status - ['installed', 'updated', 'unchanged'], force - set by PlugInstall or PlugUpdate}
  function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      " !python3 ./install.py --all
      !python3 ./install.py --clangd-completer --go-completer --ts-completer --rust-completer
    endif
  endfunction
  Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
  
  " ALE providing linting (syntax checking and semantic errors)
  Plug 'w0rp/ale'

  " 👀 " / @ / CTRL-R, Extends " and @ <CTRL-R> so you can see the contents of the registers.
  " Plug 'junegunn/vim-peekaboo'

  " insert or delete brackets, parens, quotes in pair under Insert mode
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  " Repeat.vim remaps . in a way that plugins can tap into it.
  Plug 'tpope/vim-repeat'

  " A Narrow Region Plugin for vim, focus on a selected region while making the rest inaccessible.
  Plug 'chrisbra/NrrwRgn', {'on':['NR', 'NW', 'WR', 'NRV', 'NUD', 'NRP', 'NRM', 'NRS', 'NRN', 'NRL']}
  
  " Aligning text
  Plug 'godlygeek/tabular', {'on': 'Tabularize'}


  " Git wrapper
  " GitGutter shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'tpope/vim-fugitive', {'on': ['G', 'Git']}
  Plug 'airblade/vim-gitgutter'

  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'vim-scripts/TaskList.vim', {'on': ['TaskList']}

  Plug 'voldikss/vim-floaterm', {'on': ['FloatermToggle', 'FloatermNew']}

  " visualizes the Vim undo tree.
  " Plug 'simnalamburt/vim-mundo'

  " ****** Custom Language bundles ****************************************************
  " The interactive scratchpad invoke by :Codi.
  Plug 'metakirby5/codi.vim'

  " ------------Golang Bundle ----------------------------------
  " Plug 'sebdah/vim-delve', {'for': 'go'}
  Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for':'go'}

  "" ------------Html/css/Javascript Bundle ----------------------------------
  Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript','typescript']}
  Plug 'AndrewRadev/tagalong.vim', {'for': ['html', 'jsx', 'javascript','typescript', 'xml']}

  " Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
  
  "" Include user's extra bundle
  if filereadable(expand(vim_home . "/.vimrc.local"))
    source vim_home . "/.vimrc.local"
  endif
call plug#end()

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" colorscheme
if &runtimepath =~ 'vim-colors-solarized'
  " let g:solarized_termcolors=256
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif
  silent! colorscheme solarized
endif

if &runtimepath =~ 'gruvbox'
  silent! colorscheme gruvbox
endif
"------------------------------------------------------------------------------
" vim-airline
" let g:airline_theme='solarized'
let g:airline_theme='deus'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep          = '▶'
let g:airline_left_alt_sep      = '»'
let g:airline_right_sep         = '◀'
let g:airline_right_alt_sep     = '«'
let g:airline_symbols.linenr    = '␊'
let g:airline_symbols.branch    = '⎇'
let g:airline_symbols.paste     = 'ρ'
let g:airline_symbols.paste     = 'Þ'
let g:airline_symbols.paste     = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_skip_empty_sections = 1

let g:airline#extensions#tabline#enabled = 1          " set showtabline=2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#prefix = '⤴' "➔, ➥, ⎇

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#readonly#symbol = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol = 'ρ'
let g:airline#extensions#virtualenv#enabled = 1

" -----------------------------------------------------------------------------
" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_no_status_line = 1
" let g:tagbar_position = 'leftabove'

nnoremap <silent> <leader>tb :TagbarToggle<CR>

" ------------------------------------------------------------------------------
" vim-grepper
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']
" Search for the current word
nnoremap <Leader>fw :Grepper -cword -noprompt<CR>
" Search for the current selection, gs{motion}, {selection}gs
nnoremap gs <plug>(GrepperOperator)
xnoremap gs <plug>(GrepperOperator)

" ------------------------------------------------------------------------------
"" fzf.vim 
if executable('fd')
  let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
endif

" The Silver Searcher
" if executable('ag')
"   let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git'
" endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = "rg --files --hidden --follow -g '!.git*/'"
endif

let g:fzf_vim = {}

" give the same prefix to the commands
let g:fzf_vim.command_prefix = 'Fzf'

let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
" jump to the existing window if possible
let g:fzf_vim.buffers_jump = 1
" display path on a separate line for narrow screens
let g:fzf_vim.grep_multi_line = 1

let g:fzf_vim.commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_vim.tags_command = 'ctags -R --exclude=.git --fields=+l' 
let g:fzf_vim.commands_expect = 'enter,ctrl-x'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'relative': v:true } }

" Build a quickfix list when multiple files are selected
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-x': function('s:build_quickfix_list') }

" Define a dictionary
" \ '"': 'Registers',
"
" Use :FZF_Rg/RG/Ag [pattern] to Search(rg) pattern in CWD
let fzf_cmd_mappings = { 
      \ ':': 'History:',
      \ '/': 'History/',
      \ "'": 'Marks',
      \ '.': 'Changes',
      \ 'b': 'Buffers',
      \ 'c': 'Commands',
      \ 'C': 'Colors', 
      \ 'e': 'Rg',
      \ 'f': 'Files',
      \ 'gc': 'Commits',
      \ 'gC': 'BCommits',
      \ 'gf': 'GFiles',
      \ 'gs': 'GFiles?',
      \ 'h': 'Helptags',
      \ 'j': 'Jumps',
      \ 'k': 'Maps',
      \ 'w': 'Lines',
      \ 'W': 'BLines',
      \ 'm': 'Marks',
      \ 'r': 'History',  
      \ 'p': 'Snippets',
      \ 't': 'BTags',
      \ 'T': 'Tags',
      \ 'v': 'Windows',
      \ }
" p -- snippet, piece
" v -- window, ventana

" :FZF_Files	              Files (runs $FZF_DEFAULT_COMMAND if defined)
" :FZF_History	            Recent opened buffers
" :FZF_Gfiles [opts]        Git files (git ls_files)
" :FZF_Gfiles?              Git files (git status)
" :FZF_Buffers?             Open buffers
" :Locate PATTERN           `locate`  command output
"
" :FZF_Rg/RG/Ag [pattern]   Search(rg) pattern
" :FZF_Lines                Lines in loaded buffers
" :FZF_BLines               Lines in the current buffer

" :FZF_Tags                 Tags in the project ( `ctags -R` )
" :FZF_BTags                Tags in the current buffer
" :FZF_Colors	              Color schemes
" :FZF_Changes              Changelist across all open buffers
" :FZF_Marks                Marks
" :FZF_Maps                 Normal mode mappings
" :FZF_Jumps                Jumps
"
" :FZF_Commits [opts]       Git commits (requires fugitive.vim)
" :FZF_BCommits [opts]      Git commits for the current buffer; visual-select lines to track changes in the range
"
" :FZF_History:             Command history
" :FZF_History/             Search history
" :FZF_Commands             Commands
" :FZF_Maps                 Normal mode mappings
" :FZF_Filetypes            File types
"
" :FZF_Snippets             Snippets 
"
" :FZF_Windows              Windows(Ventanas)
" :FZF_Colors               Color schemes
" :FZF_Helptags             Help tags 
  
" Iterate over the dictionary
for [key, value] in items(fzf_cmd_mappings)
   execute 'nnoremap <silent> <leader>f' . key . ' :' . g:fzf_vim.command_prefix . value . '<CR>'
endfor
nnoremap <C-p> :call ContextualFZF()<CR>
" Search text in current buffer or opened buffers
execute 'nnoremap <silent> <leader>s' . ' :' . g:fzf_vim.command_prefix . 'BLines<CR>'
execute 'nnoremap <silent> <leader>S' . ' :' . g:fzf_vim.command_prefix . 'Lines<CR>'

function! ContextualFZF()
    " Determine if inside a git repo
    silent exec "!git rev-parse --show-toplevel"
    redraw!

    if v:shell_error
        " Search in current directory
        call fzf#vim#files("", {'options': ['--layout=reverse', '--preview', 'cat {}']}, 0)
    else
        " Search in entire git repo
        call fzf#vim#gitfiles("?", {'options': ['--layout=reverse', '--preview', 'cat {}']}, 0)
    endif
endfunction

" Search and Insert word/path/line via fzf
inoremap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <c-x><c-l> <plug>(fzf-complete-line)

"------------------------------------------------------------------------------
" YouCompleteMe
" -- YCM General Options
let g:ycm_filetype_whitelist = {
  \ '*': 1,
  \ 'ycm_nofiletype': 1
  \ }
let g:ycm_filetype_blacklist = {
  \   'notes': 1,
  \   'unite': 1,
  \   'tagbar': 1,
  \   'pandoc': 1,
  \   'qf': 1,
  \   'vimwiki': 1,
  \   'infolog': 1,
  \ }

let g:ycm_filetype_specific_completion_to_disable = {
  \   'gitcommit': 1,
  \   'haskell': 1,
  \   'ruby': 1,
  \ }
let g:ycm_filepath_blacklist = {
  \ 'html' : 1,
  \ 'jsx' : 1,
  \ 'xml' : 1,
  \ }

" let g:ycm_keep_logfiles = 0
" let g:ycm_log_level = 'info'
" let g:ycm_log_level = 'debug'

" Defines where 'GoTo*' commands result should be opened.
let g:ycm_goto_buffer_command = 'same-buffer'


" -- Identifier Completion and General Semantic Completion Options

" When g:ycm_auto_trigger is 0, YCM sets the completefunc, so <C-x><C-u> manually trigger normal completion
" let g:ycm_auto_trigger = 1

" semantic suggestion will override UltiSnips and identifier suggestion,
let g:ycm_semantic_triggers = {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::', 're!\w{4}'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'java,python,scala,go' : ['.', 're!\w{4}'],
  \   'javascript,jsx,javascript.jsx,typescript,typescript,tsx' : ['.', 're!\w{4}'],
  \   'cs,d,perl6,vb,elixir' : ['.'],
  \   'ruby,rust' : ['.', '::', 're!\w{2}'],
  \   'lua' : ['.', ':', 're!\w{2}'],
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

" Trigger (default: <C-SPACE>) semantic completion anywhere. 
let g:ycm_key_invoke_completion = '<C-n>'

let g:ycm_disable_for_files_larger_than_kb = 8000

let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

" By default, YCM's filepath completion will interpret relative paths 
" as being relative to the folder of the file of the currently active buffer.
" let g:ycm_filepath_completion_use_working_dir = 0
"
" let g:ycm_use_ultisnips_completer = 1
" let g:ycm_cache_omnifunc = 1

" Use the preview window at the top of the file to store detailed information about the current completion
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" let g:ycm_disable_signature_help = 1
" let g:ycm_signature_help_disable_syntax = 0

" let g:ycm_enable_inlay_hints = 0
" let g:ycm_clear_inlay_hints_in_insert_mode = 1

" -- C-family Semantic Completion
"
" YouCompleteMe uses clangd, which makes use of clang compiler also referred to as LLVM. 
let g:ycm_use_clangd = 1
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
let g:ycm_clangd_args = ['-log=verbose', '-pretty']
" let g:ycm_clangd_args = []
let g:ycm_clangd_uses_ycmd_caching = 0

" Like any compiler, clang also requires a set of compile flags in order to parse your code. 
" There are 2 methods that can be used to provide compile flags to clang:
" Option 1: Use a compilation database, A compilation database is usually generated by your build system (e.g. CMake) 
"   If no .ycm_extra_conf.py is found, YouCompleteMe automatically tries to load a compilation database if there is one.
" Option 2: Provide the flags manually
"   If you don't have a compilation database or aren't able to generate one, 
"   you have to tell YouCompleteMe how to compile your code some other way.
"   You could also consider using YCM-Generator to generate the ycm_extra_conf.py file.

" YCM looks for a .ycm_extra_conf.py file in the directory of the opened file or in any directory above it in the hierarchy (recursively)
" You can also provide a path to a global configuration file with the g:ycm_global_extra_conf option, which will be used as a fallback.
" let g:ycm_global_ycm_extra_conf = expand(g:vim_home ."/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py")
" let g:ycm_extra_conf_globlist = []
" let g:ycm_confirm_extra_conf = 0
"
" let g:ycm_extra_conf_vim_data = []
" Ref: using YCM-Generator (https://github.com/rdnetto/YCM-Generator) to generate the ycm_extra_conf.py file.


" -- JAVA Semantic Completion
" conflict with other dianostics plugins like Syntastic and Eclim
let g:syntastic_java_checkers = []
let g:EclimFileTypeValidate = 0

" -- C# Semantic Completion
" let g:ycm_auto_start_csharp_server = 1
" let g:ycm_auto_stop_csharp_server = 1
" let g:ycm_csharp_server_port = 0
" let g:ycm_csharp_insert_namespace_expr = ''
" let g:ycm_roslyn_binary_path = 'path of Omnisharp-Roslyn executable'

" -- Python Semantic Completion
" YCM relies on the Jedi engine to provide completion and code navigation. 
" By default, it will pick the version of Python (fisrt in PATH) running the ycmd server (jedi) and use its sys.path. 
" While this is fine for simple projects, this needs to be configurable when working with 
" virtual environments or in a project with third-party packages. 
" The YCM client running inside Vim always uses the Python interpreter that's embedded inside Vim.

" Configuring the version of Pathon and third_party packages through Vim options:
" let g:ycm_python_interpreter_path = ''
" let g:ycm_python_sys_path = []
" let g:ycm_extra_conf_vim_data = [
"   \  'g:ycm_python_interpreter_path',
"   \  'g:ycm_python_sys_path'
"   \]
" let g:ycm_global_ycm_extra_conf = '~/ycm_global_extra_conf.py'
" Pass g:ycm_extra_conf_vim_data to ~/ycm_global_extra_conf.py
" def Settings( **kwargs ):
  " client_data = kwargs[ 'client_data' ]
  " return {
  "   'interpreter_path': client_data[ 'g:ycm_python_interpreter_path' ],
  "   'sys_path': client_data[ 'g:ycm_python_sys_path' ]
  " }
"

" -- Rust Semantic Completion
let g:ycm_rustc_binary_path = exepath('rustc')
let g:ycm_rust_toolchain_root = fnamemodify(exepath('cargo'), ':h')

" -- golang Semantic Completion
" Completions and GoTo commands should work out of the box
"
let g:ycm_gopls_binary_path = exepath('gopls')
" let g:ycm_gopls_args = []

" -- JavaScript and TypeScript Semantic Completion
" All JavaScript and TypeScript features are provided by the TSServer engine, which is included in the TypeScript SDK.
" TSServer relies on the jsconfig.json file for JavaScript and the tsconfig.json file for TypeScript to analyze your project.
"
" let g:ycm_tsserver_binary_path = ''

" -- Semantic Completion for Other Languages
" Using omnifunc for semantic completion.
" Vim comes with rudimentary omnifuncs for various languages like Ruby, PHP, etc.
let g:ycm_language_server = [
  \   { 'name': 'docker',
  \     'filetypes': [ 'dockerfile' ],
  \     'cmdline': [ 'docker-langserver', '--stdio' ]
  \   },
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ 'vim-language-server', '--stdio' ]
  \   },
  \   {
  \     'name': 'json',
  \     'cmdline': [ 'typescript-language-server', '--stdio' ],
  \     'filetypes': [ 'json' ],
  \   },
  \   { 'name': 'lua',
  \     'filetypes': [ 'lua' ],
  \     'cmdline': ['lua-language-server'],
  \     'capabilities': { 'textDocument': { 'completion': { 'completionItem': { 'snippetSupport': v:true } } } },
  \     'triggerCharacters': []
  \   },
  \ ]
" -- Semantic Highlighting and Diagnostic Options
" leave it alone, vim builtin syntax handle it.
" let g:ycm_enable_semantic_highlighting = 1

" turns off YCM's diagnostic display features, which override ale's dianostics
" let g:ycm_show_diagnostics_ui = 1
" let g:ycm_max_diagnostics_to_display = 30
" let g:ycm_enable_diagnostic_signs = 1
" let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_error_symbol = '*>'
let g:ycm_warning_symbol = '>>'

" shows documentation in a popup at the cursor location after a short delay.
" default: 'CursorHold', the popup is displayed on the 'CursorHold' autocommand. 
let g:ycm_auto_hover='' 
let g:ycm_show_detailed_diag_in_popup = 1

let g:ycm_echo_current_diagnostic = 1
let g:ycm_update_diagnostics_in_insert_mode = 0
" let g:ycm_always_populate_location_list = 0
" let g:ycm_open_loclist_on_ycm_diags = 1

" DON'T use filter which cause error in mousemove event
" let g:ycm_filter_diagnostics = {
"    \ 'java': {
"        \ 'regex': [ 'ta.+co', '*'],
"        \ 'level': 'error',
"        \ },
"    \ }

" let g:ycm_min_num_of_chars_for_completion = 2
" let g:ycm_min_num_identifier_candidate_chars = 0
" let g:ycm_max_num_identifier_candidates = 10
" let g:ycm_max_num_candidates = 50
" let g:ycm_max_num_candidates_to_detail = 0er>B :YcmForceCompileAndDiagnostics<CR>

if !empty(globpath(&rtp, 'plugged/YouCompleteMe'))
  " -- GoTo Commands (search and jumpto/GoTo{*})
  
  " switch between .c/cpp <--> .h  *.go <--> *_test.go
  nnoremap  <M-f> :YcmCompleter GoToAlternateFile<CR>  
  " The GoTo command tries to perform the 'most sensible' 
  " look up the symbol under the cursor and jumps to its definition if possible, or its declaration
  nnoremap go :YcmCompleter GoTo<CR>
  nnoremap gd :YcmCompleter GoToDefinition<CR>
  nnoremap <C-]> :YcmCompleter GoToDefinition<CR>
  nnoremap gD :YcmCompleter GoToDeclaration<CR>
  nnoremap grI :YcmCompleter GoToInclude<Space>
  nnoremap grr :YcmCompleter GoToReferences<CR>
  nnoremap gri :YcmCompleter GoToImplementation<CR>
  nnoremap grs :YcmCompleter GoToSymbol<CR>
  nnoremap grt :YcmCompleter GoToType<CR>
  nnoremap gO :YcmCompleter GoToDocumentOutline<CR>

  nnoremap grc :YcmCompleter GoToCallers<CR>
  nnoremap grC :YcmCompleter GoToCallees<CR>

  noremap gh <Nop>
  nnoremap ght <Plug>(YCMTypeHierarchy)
  nnoremap ghc <Plug>(YCMCallHierarchy)

  nnoremap <leader>fs <Plug>(YCMFindSymbolInDocument)
  nnoremap <leader>fS <Plug>(YCMFindSymbolInWorkspace)

  " -- Semantic Information Commands
  "  :GetType
  "  :GetParent
  "  :GetDoc
  
  " Overrid built-in K function, which run 'keywordprg' to lookup the keyword under the cursor.
  " Manually trigger or hide the popup for showing documentation (vs. g:ycm_auto_hover)
  " The displayed documentation is selected heuristically in this order of preference: :GetHover, :GetDoc, and then :GetType.
  nnoremap <silent> K <plug>(YCMHover)
  " It's selected heuristically in this order of preference:
  "   - GetHover with markdown syntax
  "   - GetDoc with no syntax
  "   - GetType with the syntax of the current file.
  " BUG: NOT work when starting from off
  inoremap <silent> <C-s> <Plug>(YCMToggleSignatureHelp)

  " -- Diagnostic and Refactoring Commands
  " Show detailed diagnostics (:YcmShowDetailedDiagnostic command)
  let g:ycm_key_detailed_diagnostics = '<Leader>dd'
  " let g:ycm_key_detailed_diagnostics = 'grd'
  nnoremap  gra :YcmCompleter FixIt<CR>
  nnoremap  grn :YcmCompleter RefactorRename<Space>
  nnoremap  gq :YcmCompleter Format<CR>
  " :OrganizeImports

  " -- AutoCompletion
  " builtin keys
  " let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
  " let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
  
  " DON'T include <C-n>, which overried g:ycm_key_invoke_completion 
  " let g:ycm_key_list_select_completion = ['<TAB>', '<C-n>', '<Down>']
  " let g:ycm_key_list_previous_completion = ['<S-TAB>', '<C-p>', '<Up>']
 
  " Import: Why YouCompleteMe does't accept the completion via <cr>.
  " Ref: https://github.com/ycm-core/YouCompleteMe/issues/232#issuecomment-15934327
  " There is nothing to 'accept', You just keep typing, the candidate has already been inserted.
  let g:ycm_key_list_stop_completion = ['<C-e>']
  
  " Customize Ycm Events
  " autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()
  " autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()
endif

"------------------------------------------------------------------------------
" UltiSnips
" YCM compatible with UltiSnips: 
"   use <Enter> to expand snippets 
"   use <Tab> to jump between snippets
" let g:UltiSnipsExpandOrJumpTrigger = '<TAB>'
let g:UltiSnipsExpandTrigger = '<enter>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
" let g:UltiSnipsListSnippets = '<C-Tab>'

" let g:UltiSnipsSnippetDirectories = [
"       \ expand(g:vim_home . '/Ultisnips'),
"       \ expand(g:vim_home. '/Ultisnips-private')
"       \ ]

let g:UltiSnipsEditSplit="vertical"
"------------------------------------------------------------------------------
" ALE, for syntax lint
" Import: 
" ALE is primarily focused on integrating with external programs through virtually any means,
" Disable all LSP features in ALE, LSP features already provided by YouCompleteMe ... 
" ALE lint/diagnostic and fix run through the whole buffer, YouCompleteMe focus on instant diagnostics.

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
" disable running the linters automatically
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" use the quickfix list instead of the loclist
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
" let g:ale_list_window_size = 10

" Ignore all lsp linters (tsserver...) for any language
" let g:ale_disable_lsp = 1

let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 0
let g:ale_completion_tsserver_autoimport = 0

let g:ale_use_neovim_diagnostics_api = 0
" The following options are ignored when using the diagnostics API:
"		- |g:ale_set_highlights|
"		- |g:ale_set_signs|
"		- |g:ale_virtualtext_cursor|
let g:ale_virtualtext_cursor = 'disabled'

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'sh': ['shellcheck'],
      \ 'javascript': ['tsserver', 'eslint'],
      \ 'typescript': ['tsserver', 'eslint'],
      \ 'python': ['flake8', 'pylint'],
      \ 'rust': ['cargo'],
      \ 'c': ['clangd'],
      \ 'cpp': ['clangd'],
      \ 'go': ['gofmt', 'gotype', 'govet', 'gopls'],
      \ 'vim': ['ale_custom_linting_rules', 'vint'],
      \ 'dockerfile': ['dockerfile_lint', 'hadolint'],
      \ 'html': ['htmlhint'],
      \ 'css': ['stylelint']
      \ }
    " \ 'go': ['gofmt', 'gotype', 'govet', 'gopls', 'staticcheck'],
    " DO NOT use golangci-lint, which can't highlight the errors when linters return non-zero exit code.
    " Use golangci-lint in automatic CI/CD process.
    " \ 'go': [ 'golangci-lint'], 

" let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'sh': ['shfmt'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'scss': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['prettier'],
      \ 'python': ['autopep8', 'yapf'],
      \ 'c': ['clang-format', 'uncrustify'],
      \ 'cpp': ['clang-format', 'uncrustify'],
      \ 'go': ['gofmt', 'gofumpt', 'goimports', 'gopls'],
      \ 'markdown': ['remove_trailing_lines'],
      \ 'vim': ['remove_trailing_lines'],
      \ }

" let g:ale_go_golangci_lint_executable = 'golangci-lint'
" Better to use {CurrentPreject}/.golangci.yml or ${HOME}/.golangci.yml configuration file
let g:ale_go_golangci_lint_options = '' " Or using command_line arguments
" Ref: golangci-lint --fix will modify files with external linter asynchronously.
" let g:ale_go_golangci_lint_options = '--enable-all -D forbidigo -D maligned -D golint -D scopelint -D interfacer -D testpackage -D paralleltest --fix'
let g:ale_go_golangci_lint_package = 1

" let g:ale_python_pylint_executable = 'pylint'
" let g:ale_python_pylint_options = '--load-plugins pylint_django'

" let g:ale_sign_column_always = 1
let g:ale_sign_error = '*>'
let g:ale_sign_warning = '>>'

" let g:ale_set_highlights = 0
" highlight ALEWarning ctermbg=DarkMagenta

let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


augroup event_ale
  autocmd!
  autocmd User ALELintPre    call <SID>ClearQuickfixList()
  autocmd User ALELintPost   call <SID>RefreshBuffersAfterLint()
augroup END

function! s:RefreshBuffersAfterLint()
  checktime
endfunction
function! s:ClearQuickfixList()
  call setqflist([])
endfunction

" ------------------------------------------------------------------------------
" auto-pairs
"
" builtin auto-pairs shortcuts
" <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
" <BS>  : Delete brackets in pair
" <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
" <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
" <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
" <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)

" Fast wrap the word
" (|)'hello' -> ('hello')
let g:AutoPairsShortcutFastWrap = '<M-s>'
let g:AutoPairs = {'(':')', '[':']', '{':'}', '<':'>',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:AutoPairsShortcutBackInsert = '<M-B>'

" ------------------------------------------------------------------------------
" vim-surround.vim
" ys{motions}{pair}         ys  - You surround   motion: iw/is/ip/f{char},
" yss{pair}                 yss - You surround whole line
" cs{old-pair}{new-pair}    cs  - change surround
" ds{pair}                  ds  - delete surround
"                           pair with extra <SPACE> using (/[/{/<, NO extra <SPACE> using )/]/}/>

" The .command will work with ds, cs, and yss if you install repeat.vim.

" ------------------------------------------------------------------------------
" NrrwRgn, A Narrow Region Plugin for vim, focus on a selected region while making the rest inaccessible.

" let g:nrrw_rgn_vert = 1
" let g:nrrw_rgn_wdth = 30
" let g:nrrw_rgn_height = 30
" let g:nrrw_topbot_leftright = 'botright'

" Incrementing the Narrowed Window size
" nmap <leader><Space> <Plug>NrrwrgnWinIncr 
" let g:nrrw_rgn_incr = 20

" NarrowRegion highlights the region that has been selected
" turn off the highlighting (because this can be distracting)
let g:nrrw_rgn_nohl = 1

" disable the mappings: <leader>nr and <leader>Nr
" :let g:nrrw_rgn_nomap_nr = 1
" :let g:nrrw_rgn_nomap_Nr = 1

" NrrwRgn-hook  

" ------------------------------------------------------------------------------
" vim-fugitive

" Ex commands with arguments is more intuitive than shortcuts in normal mode
noremap <Leader>gg :Git<CR>
" noremap <Leader>gs :Git switch
" noremap <Leader>gw :Gwrite<CR>
" noremap <Leader>gr :Gread<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gc :Git commit --verbose<CR>
" noremap <Leader>gB :Git rebase -i<CR>
" noremap <Leader>gx :GDelete<CR>
"
" close automatically the buffer created by openning git object using fugitive.
autocmd BufReadPost fugitive://* set bufhidden=delete

" -----------------------------------------------------------------------------
" vim-gitgutter
let g:gitgutter_max_signs = 2048
" let g:gitgutter_preview_win_floating = 1

" builtin mapping keys
" let g:gitgutter_map_keys = 1
" jump between hunks -- [c and ]c
" preview hunks      -- <leader>hp    :GitGutterPreviewHunk  
" stage hunks        -- <leader>hs    :GitGutterStageHunk
" BUG: 
" undo hunks         -- <leader>hu    :GitGutterUndoHunk

nnoremap ]h <Plug>(GitGutterNextHunk)
nnoremap [h <Plug>(GitGutterPrevHunk)

" :GitGutterToggle
" :GitGutterSignsToggle
" :GitGutterLineHighlightsToggle
" :GitGutterLineNrHighlightsToggle
noremap <M-g> :GitGutterBufferToggle<CR>

nnoremap <leader>hq :GitGutterQuickFix \| copen<CR>
nnoremap <leader>hd :GitGutterDiffOrig<CR>

" builtin hunk text object is provided which works in visual and operator-pending modes.
" TODO: conflix with vim-go's go#textobj#Comment
" ic operates on all lines in the current hunk.
" ac operates on all lines in the current hunk and any trailing empty lines.
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" -----------------------------------------------------------------------------
" vim-bookmarks
" don't override built-in mark
let g:bookmark_no_default_key_mappings = 1
nnoremap <Leader>mm <Plug>BookmarkToggle
nnoremap <Leader>mi <Plug>BookmarkAnnotate
nnoremap <M-m> <Plug>BookmarkShowAll
nnoremap <Leader>mn <Plug>BookmarkNext
nnoremap <Leader>mp <Plug>BookmarkPrev
nnoremap <Leader>mc <Plug>BookmarkClear
nnoremap <Leader>mx <Plug>BookmarkClearAll

" -----------------------------------------------------------------------------
" TaskList.vim
map <leader>tl <Plug>TaskList
let g:tlWindowPosition = 1
" TODO: highlight custom token, like what is done in /usr/share/vim/vim90/syntax/go.vim
" yn keyword     goTodo              contained TODO FIXME XXX BUG
let g:tlTokenList = ['TODO', 'FIXME', 'XXX', 'BUG', 'FIXIT', 'FIX', 'ERROR', 'WARN']
let g:tlRememberPosition = 1
" ------------------------------------------------------------------------------
" vim-floaterm
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8
let g:floaterm_opener = 'edit'
let g:floaterm_autoclose = 2

nnoremap   <silent>   <M-3> :FloatermToggle<CR>
nnoremap   <silent>   <M-\> :FloatermToggle<CR>

tnoremap   <silent>   <M-3> <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <M-\> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_keymap_kill   = '<C-d>'
" let g:floaterm_keymap_next   = ']f'
" let g:floaterm_keymap_prev   = '[f'

" ft/floaterm somefile.txt, open files from within :terminal without starting a nested nvim
" Execute git commit in the terminal window without starting a nested vim/nvim.
" :FloatermNew fzf
" :FloatermNew rg

" -----------------------------------------------------------------------------
" Golong, vim-go
let g:go_version_warning = 0

let g:go_code_completion_enabled = 0
" let g:go_code_completion_icase = 0

let g:go_auto_type_info = 0
let g:go_info_mode = 'gopls'

let g:go_play_open_browser = 0
" let g:go_play_browser_command = '' ['', 'chrome' 'firefox-developer %URL% &' ]
  
" let g:go_test_show_name = 0
let g:go_test_timeout= '10s'

let g:go_auto_sameids = 0

let g:go_jump_to_error = 0

" let g:go_updatetime = 800

let g:go_fmt_autosave = 0
" let g:go_fmt_command = 'gopls'    ['gofmt','goimports']
" let g:go_fmt_options = {
"   \ 'gofmt': '-s',
"   \ 'goimports': '-local mycompany.com',
"   \ }
" let g:go_fmt_fail_silently = 0
" let g:go_fmt_experimental = 0

let g:go_imports_autosave = 0
" let g:go_imports_mode = 'gopls'

let g:go_mod_fmt_autosave = 0
" let g:go_asmfmt_autosave = 0

" run `godoc` on words under the cursor with |K|, which override the 'keywordprg' setting 
" let g:go_doc_keywordprg_enabled = 1
let g:go_doc_max_height = 25
" let g:go_doc_url = 'https://pkg.go.dev'
let g:go_doc_popup_window = 1
" let g:go_doc_balloon = 0


let g:go_def_mode = 'gopls'
let g:go_fillstruct_mode = 'gopls'
let g:go_referrers_mode = 'gopls'
let g:go_implements_mode = 'gopls'

" Jumps to an existing buffer when Goto [type] declaration/definition.
let g:go_def_reuse_buffer = 1

" let g:go_bin_path = ''
" let g:go_search_bin_path_first = 1
let g:go_get_update = 0

let g:go_snippet_engine = 'ultisnips' " ['automatic', 'ultisnips', 'neosnippet', 'minisnip']


" let g:go_build_tags = ''

" let g:go_textobj_enabled = 1
" let g:go_textobj_include_function_doc = 1
" let g:go_textobj_include_variable = 1

let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave = 0
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_deadline = '5s'

" let g:go_list_type = ""
let g:go_list_height = 10
" let g:go_list_type_commands = {}
" let g:go_list_type_commands = {'GoBuild': 'locationlist'}
" let g:go_list_autoclose = 1


let g:go_term_enabled = 1
let g:go_term_mode = 'split'
let g:go_term_reuse = 1
let g:go_term_width = 30
let g:go_term_height = 10
let g:go_term_close_on_exit = 1

let g:go_alternate_mode = 'edit'

" let g:go_rename_command = 'gopls'
let g:go_gorename_prefill = 'expand("<cword>") =~# "^[A-Z]"' .
      \ '? go#util#pascalcase(expand("<cword>"))' .
      \ ': go#util#camelcase(expand("<cword>"))'


let g:go_gopls_enabled = 1
"
" TODO: wait for a solution for sharing gopls instance between vim-go, YouCompleteMe, Ale and other plugins.
" The commandline arguments to pass to gopls. By default, `['-remote=auto']`.
" configure vim-go to share the `gopls` instance with other LSP plugins via 'g:go_gopls_options'
" let g:go_gopls_options = ['-remote=auto']

" let g:go_gopls_analyses = v:null
" let g:go_gopls_complete_unimported = v:null
" let g:go_gopls_deep_completion = v:null
" let g:go_gopls_matcher = v:null
" let g:go_gopls_staticcheck = v:null
" let g:go_gopls_use_placeholders = v:null
" let g:go_gopls_temp_modfile = v:null
" let g:go_gopls_local = v:null
" let g:go_gopls_gofumpt = v:null
" let g:go_gopls_settings = v:null

" 0 ignores `gopls` diagnostics, 1 is for errors only, and 2 is for errors and warnings. By default, 0.
" YouCompleteMe does it.
let g:go_diagnostics_level = 2

" let g:go_template_autocreate = 1
" let g:go_template_file = 'hello_world.go'
" let g:go_template_test_file = 'hello_world_test.go'
let g:go_template_use_pkg = 1

let g:go_decls_includes = 'func,type'
let g:go_decls_mode = 'fzf'

" let g:go_echo_command_info = 1
let g:go_echo_go_info = 0
" let g:go_statusline_duration = 60000

" let g:go_addtags_transform = 'snakecase'
" let g:go_addtags_skip_unexported = 0

" let g:go_debug = []

" let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
" let g:go_highlight_function_parameters = 0
" let g:go_highlight_function_calls = 0
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 0
" let g:go_highlight_generate_tags = 0
" let g:go_highlight_chan_whitespace_error = 0
" let g:go_highlight_array_whitespace_error = 0
" let g:go_highlight_space_tab_error = 0
" let g:go_highlight_trailing_whitespace_error = 0
" let g:go_highlight_format_strings = 1
" let g:go_highlight_variable_declarations = 0
" let g:go_highlight_variable_assignments = 0
let g:go_highlight_string_spellcheck = 0
" let g:go_highlight_diagnostic_errors = 1
" let g:go_highlight_diagnostic_warnings = 1


" debugger options
" let g:go_debug_windows = {
"       \ 'vars':       'leftabove 30vnew',
"       \ 'stack':      'leftabove 20new',
"       \ 'goroutines': 'botright 10new',
"       \ 'out':        'botright 5new',
"       \ }

let g:go_debug_preserve_layout = 1
" let g:go_debug_address = '127.0.0.1:8181'
" An empty string (`''`) will suppress logging entirely.  Default: `'debugger,rpc'`:
" let g:go_debug_log_output = '' ['debugger,rpc']
" let g:go_highlight_debug = 1
let g:go_debug_breakpoint_sign_text = '💩'
" let g:go_debug_current_line_symbol='👻'


augroup event_golang
  autocmd!
  " :GoInstallBinaries      Download and install all necessary Go tool binaries
  " :GoUpdateBinaries       Download and update previously installed Go tool binaries 
  " :GoPath                 GoPath sets and overrides GOPATH with the given {path}.
  
  " :GoAddWorkspace [dir]   Add directories to the `gopls` workspace.
  " :GoModFmt               Filter the current go.mod buffer through 'go mod edit -fmt' command.  
  " :GoModReload            Force `gopls` to reload the go.mod file. 
  
  autocmd FileType go nnoremap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>
  " autocmd FileType go nnoremap <buffer> <leader>b  <Plug>(go-build)
  autocmd FileType go nnoremap <buffer> <leader>r  <Plug>(go-run)
  " autocmd FileType go nnoremap <buffer> <leader>gG  <Plug>(go-generate)

  autocmd FileType go nnoremap <buffer> <leader>tt <Plug>(go-test)
  autocmd FileType go nnoremap <buffer> <leader>tf <Plug>(go-test-func)
  autocmd FileType go nnoremap <buffer> <leader>tF <Plug>(go-test-file)

  autocmd FileType go nnoremap <buffer> <leader>tc <Plug>(go-coverage)
  autocmd FileType go nnoremap <buffer> <leader>tC <Plug>(go-coverage-toggle) 

  " :GoInstall    Install your package with `go install`.
  " :GoImport     Import ensures that the provided package {path} is imported in the current buffer.
  " :GoGenerate   Creates or updates your auto-generated source files by running `go generate`.
  " :GoBuild      Build package with `go build, `:GoBuild` doesn't produce a result file.
  " :GoBuildTags  Changes the build tags for various commands.
  " :GoRun        Build and run your current main package. 
  " :GoTest       Run the tests on your _test.go files in your current directory. Errors
  " :GoTestFile
  " :GoTestFunc
  " :GoTestCompile
  " :GoCoverage   Create a coverage profile and annotates
  " :GoCoverageToggle

  autocmd FileType go nnoremap <M-f> <Plug>(go-alternate-edit)
  autocmd Filetype go command! -bang -buffer A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang -buffer AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang -buffer AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang -buffer AT call go#alternate#Switch(<bang>0, 'tabe')
  " :GoAlternate         Alternates between the implementation and test code. 
  
  " ]] -> jump to next function
  " [[ -> jump to previous function

  " 'K' normally runs the `man` program, but for Go using `godoc` is more idiomatic.
  let g:go_doc_keywordprg_enabled = 1
  " autocmd FileType go nnoremap <buffer> K <Plug>(go-doc)
  
  " Use this option to enable/disable 
  " gd/<C-]>        :GoDef
  " CTRL-t          :GoDefPop, 
  " gD              :GoDefType.
  let g:go_def_mapping_enabled = 1
  " Show the interfaces that the type under the cursor implements.
  autocmd FileType go nnoremap <buffer> <leader>gi <Plug>(go-implements)
  autocmd FileType go nnoremap <buffer> <leader>gs <Plug>(go-callstack)
  autocmd FileType go nnoremap <buffer> <leader>gp <Plug>(go-channel-peers)
  autocmd FileType go nnoremap <buffer> <leader>gr <Plug>(go-referrers)
  " :GoDoc          Open the relevant GoDoc in split window
  " :GoInfo         Show type information
  " :GoDef          Go to declaration/definition 
  " :GoDefType,     Go to type definition 
  "
  " :GoDefStack,    Jumps to a given location in the jumpstack
  " :GoDefPop       Navigate to the [count] earlier entry in the jump stack
  " :GoSameIds      Highlights all identifiers that are equivalent to the identifier 
  " :GoDiagnostics  Displays the diagnostics from `gopls` for the given packages 
  "
  " :GoFiles        Show source files for the current package
  " :GoDeps         Show dependencies for the current package.
  " :GoDecls        Show all function and type declarations for the current file.
  " :GoDecls        Show all function and type declarations for the current directory.
  
  " :GoImpl         Generates method stubs for implementing an interface.
  " :GoAddTags      Adds field tags for the fields of a struct. 
  " :GoRemoveTags   Remove field tags for the fields of a struct. 
  " :GoRename       Rename the identifier under the cursor to the desired new name. 
  " :[range]GoExtract   Extract the code fragment in the selected line range to a new function 
  autocmd FileType go nnoremap <buffer> <leader>gI :GoImpl<Space>
  autocmd FileType go nnoremap <buffer> <leader>gR :GoRename<Space>
  autocmd FileType go nnoremap <buffer> <leader>ge <Plug>(go-if-err)
  autocmd FileType go nnoremap <buffer> <leader>gf <Plug>(go-fill-struct)

  " :GoFillStruct     Use `fillstruct` to fill a struct literal with default values.
  " :GOIfErr          Generate if err != nil { return ... } automatically which infer the type of return values and the numbers.

  " :GoFmt
  " :GoLint           lint code 
  " :GoVet,           catch  static errors 
  " :GoErrCheck,      make sure errors 
  " :GoMetaLinter     call `golangci-lint` to invoke all possible linters (`golint`, `vet`, `errcheck`, `deadcode`, etc.) 
  
  " Only :GoDebugAttach, :GoDebugStart, :GoDebugTest, and :GoDebugBreakpoint are available by default.
  " The rest of the commands and mappings become available after executing :GoDebugContinue.
  autocmd FileType go nnoremap <buffer> <F5> :GoDebugStart<cr>
  autocmd FileType go nnoremap <buffer> <S-F5> <Plug>(go-debug-stop)
  " Someone said 'In practice, TUI Vim is unable to distinguish between <F5>, <S-F5>, and <C-S-F5>, which all send the same character sequence.', but not for sure.
  " autocmd FileType go nnoremap <buffer> <F6> :GoDebugAttach 
  autocmd FileType go nnoremap <buffer> <F7> :GoDebugTest<cr>
  " GoDebugAttach pid
  " :GoDebugConnect [addr] [default, g:go_debug_address]
  " :GoDebugTest
  " :GoDebugTestFunc
  " :GoDebugRestart  
  
  " Contains custom key mapping information to customize the active mappings when debugging.
  " Todo: keys only valid for the active mapping, to be updated.
  " (the default mappingsm https://github.com/fatih/vim-go/issues/3012)
  
  " BUG: Assigning any key to '(go_debug_stop)' doesn't work
  " Valid keys defined by configureMappings function in plugged/vim-go/autoload/go/debug.vim:
  let g:go_debug_mappings = {
    \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
    \ '(go-debug-print)':{'key': 'p', 'arguments': '<nowait>'},
    \ '(go-debug-breakpoint)': {'key': 'b','arguments': '<nowait>'},
    \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
    \ '(go-debug-step)': {'key': 's', 'arguments': '<nowait>'},
    \ '(go-debug-stepout)': {'key': 'S', 'arguments': '<nowait>'},
    \ '(go-debug-halt)': {'key': '<SPACE>'},
    \ '(go-debug-stop)': {'key': 'q'}
    \}

  " c         <F5>      :GoDebugContinue
  " <SPACE>   <F8>      :GoDebugHalt
  " b         <F9>      :GoDebugBreakpoint
  " n         <F10>     :GoDebugNext            step over
  " s         <F11>     :GoDebugStep            step in
  " S                   :GoDebugStep            step out
  " p                   :GoDebugPrint
  " q/T
  " memo: put cursor on variable and press 'p' to print out the value
  "
  " :GoDebugSet {var} {value}
  " :GoDebugPrint {expr}
  
augroup END

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" -----------------------------------------------------------------------------
" emmet-vim
let g:user_emmet_install_global = 0
" default emmet leader key is <c-y>
" <C-,> is not available on mac m1
let g:user_emmet_leader_key='<C-m>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}
" let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_mode='a'    "enable all function in all mode.
