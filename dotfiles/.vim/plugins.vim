" *****************************************************************************
" Vim-PLug 
let vimplug_exists=expand(g:vim_home. '/autoload/plug.vim')
let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr 'You have to install curl or first install vim-plug yourself!'
    execute 'q!'
  endif
  echo 'Installing Vim-Plug...'
  echo ''
  silent exec '!'curl_exists' -fLo ' . shellescape(vimplug_exists) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let g:not_finish_vimplug = 'yes'

  autocmd VimEnter * PlugInstall
endif

" ****************************************************************************
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
" specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
" Make sure you use single quotes
call plug#begin(g:vim_data . '/plugged')
  " Try load plugins lazily as possible

  " colorscheme
  Plug 'sainnhe/everforest'
 
  " Status/tabline for vim
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Universal CTags: tagging engine that scans project files and generates tag files.
  " Tagbar: displays a window with a hierarchical list of tags in the current file.
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

  " Grepper plugin run grep-like tools(ag, ack, git grep, ripgrep) asynchronously.
  Plug 'mhinz/vim-grepper', { 'on': [ 'Grepper', 'GrepperGrep', 'GrepperRg', 'GrepperGit', '<plug>(GrepperOperator)'] }

  " fzf, Fuzzy finder: file, buffer, mru, tag, etc. asynchronous and fast.
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
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
  endif
  Plug 'junegunn/fzf.vim'

  Plug 'yegappan/lsp'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'ervandew/supertab'
  " a suite consist of supertab, lsp, asyncomplete and ultisnips

  " insert or delete brackets, parens, quotes in pair under Insert mode
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'

  " Aligning text
  " Plug 'godlygeek/tabular', { 'on': 'Tabularize'}

  " Git wrapper, don't lazy load since airline require it.
  Plug 'tpope/vim-fugitive'
  " GitGutter shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'airblade/vim-gitgutter'

  Plug 'MattesGroeger/vim-bookmarks', { 'on': [ 'BookmarkToggle', 'BookmarkAnnotate', 'BookmarkNext', 'BookmarkPrev', 'BookmarkShowAll', 'BookmarkClear', 'BookmarkClearAll', 'BookmarkSave', 'BookmarkLoad']}
  Plug 'vim-scripts/TaskList.vim', { 'on': [ 'TaskList' ]}

  Plug 'voldikss/vim-floaterm', { 'on': [ 'FloatermToggle', 'FloatermNew']}

  " A Vim wrapper for running tests on different granularities.
  Plug 'tpope/vim-dispatch'
  Plug 'vim-test/vim-test', { 'on': [ 'TestNearest', 'TestClass', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit']}

  " doPost-update hook (string or funcref), install or upgrade gadgets (Debug Adapters)
  Plug 'puremourning/vimspector', { 'do': ':VimspectorUpdate' }

  " ****** Custom Language bundles ****************************************************
  " Golang Bundle --------------------------------------------------------------------
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go'}

  " Bundle ----------------------------------------------------------------------
  " Plug 'rust-lang/rust.vim', { 'for': 'rust'}

  " css/Javascript Bundle -----------------------------------------------------
  Plug 'mattn/emmet-vim', {'for': [ 'html', 'css', 'javascript', 'typescript']}
  Plug 'AndrewRadev/tagalong.vim', {'for': [ 'html', 'jsx', 'javascript', 'typescript', 'xml']}

  " define keymap centralized and help to memerize
  Plug 'liuchengxu/vim-which-key', { 'on': [ 'WhichKey', 'WhichKey!', 'WhichKeyVisual'] }

call plug#end()

" colorscheme ------------------------------------------------------------------------------
if &runtimepath =~ 'everforest'
  if has('termguicolors')
    set termguicolors
  endif
  
 let g:everforest_background = 'soft'
 let g:everforest_better_performance = 1
  
  " configuration option should be placed before `colorscheme everforest`.
  silent! colorscheme everforest
elseif &runtimepath =~ 'vim-colors-solarized'
  let g:solarized_termcolors=256
  silent! colorscheme solarized
elseif &runtimepath =~ 'gruvbox'
  silent! colorscheme gruvbox
endif

" vim-airline-----------------------------------------------------------------------------
let g:airline_experimental = 1
let g:airline_theme='lucius'
" TODO: try to implement for airline
" let g:airline_theme='everforest'
" let g:airline_detect_iminsert = 1
let g:airline_skip_empty_sections = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.executable = '⚙'
let g:airline_symbols.readonly = '⊘'
let g:airline_symbols.linenr = ' ␤:'
" let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.maxlinenr = ':'
" let g:airline_symbols.branch = '⎇'
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

let g:airline_extensions = ['branch', 'hunks', 'vim9lsp']
" vim9lsp -- yegappan/lsp 
" hunks -- vim-gitgutter, vim-signify, changesPlugin, quickfixsigns, coc-git, or gitsigns.nvim 
" branch -- fugitive.vim, gina.vim, lawrencium, or vcscommand

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#lsp#enabled = 1
let g:airline#extensions#hunks#enabled = 1
" let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

let g:airline#extensions#tabline#enabled = 0          " set showtabline=2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'b'

let g:airline#extensions#vim9lsp#enabled = 1
let g:airline#extensions#vim9lsp#error_symbol = ' '
let g:airline#extensions#vim9lsp#warning_symbol = ' '

" Tagbar ----------------------------------------------------------------------------
let g:tagbar_autofocus = 1
let g:tagbar_no_status_line = 1
" let g:tagbar_position = 'leftabove'

" vim-grepper -----------------------------------------------------------------------------
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']
" Search for the current word
nnoremap <Leader>fw :Grepper -cword -noprompt<CR>
" Search for the current selection, gs{motion}, {selection}gs
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

"" fzf.vim -----------------------------------------------------------------------------
if executable('fd')
  let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!.git*/"'
endif

" All configuration values for this plugin are stored in g:fzf_vim dictionary,
" make sure to initialize it before assigning any configuration values to it
let g:fzf_vim = {}

let g:fzf_vim.command_prefix = 'Fzf'
let g:fzf_vim.preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']
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
  call setqflist(map(copy(a:lines), "{ 'filename': v:val }"))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-x': function('s:build_quickfix_list') }

" use Ex-commands if having options or arguments instead of keymaps
" :FzfFiles [PATH]
" :FzfGFiles [OPTS]
" :FzfRg [pattern]  -- fuzzy find on 'rg pattern'
" :FzfAg [pattern]  -- fuzzy find on 'ag pattern'

" Useful shortcuts for text/pattern search commands:
" /                 -- builtin search forward for pattern
" <leader>/ BLine   -- Lines (search with pattern) in the current buffer
" <leader>s Line    -- Lines (search with pattern) in loaded buffers
" <leader>S RG      -- 'Live' rg search (search with pattern) the files of CWD
"                       rg search result; relaunch ripgrep on every keystroke
" :FzfRg [pattern]  -- rg search result with pattern 

" Search text in current buffer or opened buffers
execute 'nnoremap <silent> <leader>/' . ' :' . g:fzf_vim.command_prefix . 'BLines<CR>'
execute 'nnoremap <silent> <leader>s' . ' :' . g:fzf_vim.command_prefix . 'Lines<CR>'
execute 'nnoremap <silent> <leader>S' . ' :' . g:fzf_vim.command_prefix . 'RG<CR>'

let fzf_cmd_mappings = {
      \ ':': 'History:',
      \ '/': 'History/',
      \ "'": 'Marks',
      \ 'b': 'Buffers',
      \ 'c': 'Commands',
      \ 'C': 'Changes',
      \ 'f': 'Files',
      \ 'gc': 'BCommits',
      \ 'gC': 'Commits',
      \ 'gf': 'GFiles',
      \ 'gs': 'GFiles?',
      \ 'h': 'Helptags',
      \ 'j': 'Jumps',
      \ 'k': 'Maps',
      \ 'm': 'BMarks',
      \ 'M': 'Marks',
      \ 'r': 'History',
      \ 's': 'Snippets',
      \ 't': 'BTags',
      \ 'T': 'Tags',
      \ 'W': 'Windows',
      \ }
" Iterate over the dictionary
for [key, value] in items(fzf_cmd_mappings)
   execute 'nnoremap <silent> <leader>f' . key . ' :' . g:fzf_vim.command_prefix . value . '<CR>'
endfor

" <laader>fr History -- v:oldfiles and open buffers
" <leader>fgf GFiles -- Git files (git ls-files)
" <leader>fgs GFiles? -- Git files (git status)

files or gitfiles
nnoremap <C-p> :call ContextualFZF()<CR>

function! ContextualFZF()
  " Try to detect git repo root
  let l:root = system('git rev-parse --show-toplevel 2>/dev/null')
  if v:shell_error
    " Search in current directory
    call fzf#vim#files('', fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), 0)
  else
    " Search in entire git repo (git-tracked files)
    call fzf#vim#gitfiles('', fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), 0)
  endif
endfunction

" override builtin complete (word, path,line)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" LSP client (yegappan/lsp) for Vim 9+ -----------------------------------------------------------------------------
"
" Enable LSP logging 
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('${HOME}/local/state/vim/lsp.log')

let lspOpts = #{
  \ autoComplete: v:true,
  \ completionTextEdit: v:false,
  \ completionMatcher: 'icase',
  \ definitionFallback: v:true,
  \ diagSignErrorText: ' ',
  \ diagSignHintText: ' ',
  \ diagSignInfoText: ' ',
  \ diagSignWarningText: ' ',
  \ diagVirtualTextAlign: 'after',
  \ filterCompletionDuplicates: v:true,
  \ hideDisabledCodeActions: v:true,
  \ highlightDiagInline: v:true,
  \ hoverFallback: v:true,
  \ outlineOnRight: v:true,
  \ omniComplete: v:true,
  \ popupBorder: v:true,
  \ popupBorderSignatureHelp: v:true,
  \ semanticHighlight: v:true,
  \ showDiagInBalloon: v:false,
  \ showInlayHints: v:false,
  \ ultisnipsSupport	: v:true,
  \ useBufferCompletion: v:false,
  \ usePopupInCodeAction: v:true,
  \ useQuickfixForLocations: v:true,
  \ }

  " \ autoComplete: v:false,  " -- true, automatically complete the current symbol. false, use omni-completion.
  " \ completionMatcher, " case, fuzzy, icase
  " \ TODO: how to do with completionTextEdit ?
  " \ completionTextEdit	" -- true, apply the LSP server supplied text edits after a completion.  
  " If a snippet plugin is going to apply the text edits, then set this to false to avoid applying the text edits twice. By default this is set to true.
  "
  " \ ignoreMissingServer, 
  " \ showInlayHints:v:false, use :LspInlayHints toggle to enable it

let g:lspServers = [ #{ name: 'golang',
\	  filetype: ['go', 'gomod'],
\   path: exepath('gopls'),
\   args: ['serve'],
\   rootSearch: [ 'go.work', 'go.mod', '.git' ],
\   syncInit: v:true,
\   workspaceConfig: #{
\     gopls: #{
\       directoryFilters: ['-**/node_modules', '-**/.git', '-**/vendor', '-**/tmp', '-**/build' ],
\       gofumpt: v:true,
\       codelenses: #{
\         gc_details: v:true,
\         generate: v:true,
\         regenerate_cgo:v:true,
\         run_govulncheck: v:true,
\         test: v:true,
\         tidy: v:true,
\         upgrade_dependency: v:true,
\         vendor: v:true,
\       },
\       usePlaceholders: v:false,
\       staticcheck: v:true,
\       analyses: #{
\         shadow: v:true,
\       },
\       diagnosticsTrigger: 'Save',
\       hints: #{
\         assignVariableTypes: v:true,
\         compositeLiteralFields: v:true,
\         compositeLiteralTypes: v:true,
\         constantValues: v:true,
\         functionTypeParameters: v:true,
\         parameterNames: v:true,
\         rangeVariableTypes: v:true
\       }
\     }
\   }
\ }, #{ name: 'rustlang',
\   filetype: ['rust'],
\   path: exepath('rust-analyzer'),
\   args: [],
\   syncInit: v:true,
\   rootSearch: [ 'Cargo.toml', '.git' ],
\   initializationOptions: #{
\     cargo: #{allFeatures: 'all'},
\     check: #{command: 'clippy'},
\     completion: #{fullFunctionSignatures: #{enable: v:true}},
\     diagnostics: #{styleLints: #{ enable: v:true }},
\     hover: #{actions: #{references: #{enable: v:true}}},
\     lens: #{
\       references:#{
\         adt: #{enable:v:true},
\         method: #{enable:v:true},
\         trait: #{enable:v:true},
\       },
\     },
\     semanticHighlighting:#{
\       punctuation: #{
\         enable: v:true,
\         separate: #{
\           macro: #{
\             bang: v:true,
\           },
\         },
\       },
\     },
\   },
\ }, #{ name: 'clangd',
\	  filetype: ['c', 'cpp', 'h', 'hpp'],
\   path: exepath('clangd'),
\	  args: ['--background-index'],
\   rootSearch: [ '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', 'compile_commands.json', 'compile_flags.txt', '.git' ],
\ },  #{ name: 'luals',
\   filetype: 'lua',
\   path: exepath('lua-language-server'),
\   args: [],
\   rootSearch: [ 'selene.toml', '.git' ],
\ }]

let node_path = exepath('node')
if empty(g:node_path)
  echoerr "Node.js not found in PATH!"
else
  let node_dir = fnamemodify(g:node_path, ':h')
  call extend(g:lspServers, [ #{ name: 'typescriptlang',
\   filetype: ['javascript', 'typescript'],
\   path: fnamemodify(printf('%s/%s', node_dir, 'typescript-language-server'), ':p'),
\   args: ['--stdio'],
\   rootSearch: [ 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' ],
\ }, #{ name: 'pyright',
\   filetype: 'python',
\   path: fnamemodify(printf('%s/%s', node_dir, 'pyright-langserver'), ':p'),
\   args: ['--stdio'],
\   workspaceConfig: #{
\     python: #{
\       pythonPath: exepath('python3'),
\   }}
\ }, #{ name: 'vimls',
\   filetype: 'vim',
\   path: fnamemodify(printf('%s/%s', node_dir, 'vim-language-server'), ':p'),
\   args: ['--stdio']
\ }, #{ name: 'bashls',
\   filetype: ['sh', 'bash', 'zsh'],
\   path: fnamemodify(printf('%s/%s', node_dir, 'bash-language-server'), ':p'),
\   args: ['start']
\ }, #{ name: 'cssls',
\   filetype: 'css',
\   path: fnamemodify(printf('%s/%s', node_dir, 'vscode-css-language-server'), ':p'),
\   args: ['--stdio'],
\ }, #{ name: 'htmlls',
\   filetype: 'html',
\   path: fnamemodify(printf('%s/%s', node_dir, 'vscode-html-language-server'), ':p'),
\   args: ['--stdio'],
\ },  #{ name: 'vscode-json-server',
\   filetype: ['json'],
\   path: fnamemodify(printf('%s/%s', node_dir, 'vscode-json-language-server'), ':p'),
\   args: ['--stdio'],
\ }, #{ name: 'vscode-markdown-server',
\   filetype: ['markdown'],
\   path: fnamemodify(printf('%s/%s', node_dir, 'vscode-markdown-language-server'), ':p'),
\   args: ['--stdio'],
\ }])
endif

function! s:IsValidServer(idx, server) abort
  " Keep only servers whose path is not empty and actually exists
  return !empty(a:server['path']) && filereadable(a:server['path'])
endfunction

let g:lspServers = filter(copy(g:lspServers), 's:IsValidServer(v:key, v:val)')

" A User autocommand fired when the LSP plugin is loaded.
autocmd! User LspSetup call LspOptionsSet(lspOpts) | call LspAddServer(g:lspServers)
" autocmd User LspSetup call LspOptionsSet(lspOpts) 
" autocmd User LspSetup call LspAddServer(g:lspServers)

" A User autocommand fired when the LSP client attaches to a buffer.
" BufReadPost --> FileType --> LspAttached in order.
autocmd User LspAttached call s:config_lsp_buf()

" A User autocommand invoked when new diagnostics are received from the language server.
" autocmd User LspDiagsUpdated

function! s:config_lsp_buf() abort
  " disable user defined completion, which conflix with yegappan/lsp autocompletion
  setlocal completefunc=''

  " Optional keymaps for LSP actions
  nnoremap <silent> <buffer> gd    :LspGotoDefinition<CR>
  nnoremap <silent> <buffer> <C-]> :LspGotoDefinition<CR>
  nnoremap <silent> <buffer> gD    :LspGotoDeclaration<CR>
  nnoremap <silent> <buffer> K     :LspHover<CR>
  nnoremap <silent> <buffer> grr   :LspPeekReferences<CR>
  nnoremap <silent> <buffer> gri   :LspGotoImpl<CR>
  nnoremap <silent> <buffer> grI   :LspPeekImpl<CR>
  nnoremap <silent> <buffer> grt   :LspGotoTypeDef<CR>
  nnoremap <silent> <buffer> gO    :LspDocumentSymbol<CR>
  nnoremap <silent> <buffer> gro   :LspOutline<CR>
  nnoremap <silent> <buffer> grc   :LspIncomingCalls<CR>
  nnoremap <silent> <buffer> grC   :LspOutgoingCalls<CR>
  nnoremap <silent> <buffer> [d    :LspDiag prev<CR>
  nnoremap <silent> <buffer> ]d    :LspDiag next<CR>
  nnoremap <silent> <buffer> [D    :LspDiag first<CR>
  nnoremap <silent> <buffer> ]D    :LspDiag last<CR>
  nnoremap <silent> <buffer> <C-k> :LspDiag current<CR>
  nnoremap <silent> <buffer> <C-w>d :LspDiag current<CR>
  nnoremap <silent> <buffer> grd   :LspDiag current<CR>
  nnoremap <silent> <buffer> grq   :LspDiag show<CR>
  nnoremap <silent> <buffer> gq    :LspFormat<CR>
  " no <silent> flag, which prevents from seeing the typing after:LspRename 
  nnoremap <buffer> grn   :LspRename<Space>
  nnoremap <silent> <buffer> gra   :LspCodeAction<CR>
  nnoremap <silent> <buffer> grl   :LspCodeLens<CR>
  nnoremap <silent> <buffer> grh   :LspShowSignature<CR>
  nnoremap <silent> <buffer> <leader>oi   :LspInlayHints toggle<CR>
  " In insert mode, you need <C-o> to execute a normal mode command
  inoremap <buffer> <C-S>   <C-o>:LspShowSignature<CR>
endfunction

highlight LspDiagVirtualText ctermfg=Cyan guifg=Blue
" highlight link LspDiagLine DiffAdd
" highlight link LspDiagVirtualText WarningMsg

" colorscheme should clear SignColumn highlight
" highlight clear SignColumn
  
" global lsp: lsp, log
nnoremap <silent> <leader>zi :LspShowAllServers<CR>
nnoremap <silent> <leader>zl :LspServer show messages<CR>

augroup event_lsp
  autocmd!
  " Auto-format before saving using vim-lsp
  autocmd BufWritePre *.go,*.py,*.ts,*.rs silent! LspFormat

  " Patch close_with_q for LspShowAllServers, which set filetype or trigger FileType (filetype='') or BufRead (buftype=nofile) at all 
  " :LspShowAllServers fail to trigger BufWinEnter event. The LSP plugin may be reusing a hidden scratch window internally (common pattern to avoid flicker), so:
	"   •	BufEnter fires each time you open it,
	"   •	BufWinEnter doesn’t, because from Vim’s perspective, that buffer has already been in that window before.
  " autocmd BufWinEnter *  call s:close_with_q_patch()
  autocmd BufEnter *  call s:close_with_q_patch()

augroup END

function! s:close_with_q_patch() abort
  let l:name = bufname('%')

  " For debugging
  " echom 'BufWinEnter fired for ' .. l:name
  
  if l:name ==# 'Language-Servers' || l:name ==# 'LangServer-Messages'
    " Avoid re-mapping q multiple times
    if empty(maparg('q', 'n', 0, 1))
      nnoremap <silent> <buffer> q :close<CR>
    endif
  endif
endfunction


" Enhanced completion setup for yegappan/lsp with fallback
" LSP completion for attached buffers, native completion for others

" Enables LSP-based completion for buffers attached to an LSP server, 
" yegappan/lsp will provide completions from the language server
" used by the yegappan/lsp plugin internally, not custom fallback function. 
" They're necessary to ensure LSP completion works properly for LSP-attached buffers.
let g:lsp_completion_enable = v:true
let g:lsp_completion_trigger_kind = 'auto'

" For non-LSP buffers, configure native completion sources
augroup FallbackCompletion
  autocmd!
  autocmd FileType call SetupFallbackCompletion()
augroup END

function! SetupFallbackCompletion()
    if IsFiletypeInLspServers(&filetype, g:lspServers)
      return
    endif

    " Check if LSP is attached to this buffer
    " yegappan/lsp sets 'omnifunc' to 'g:LspOmniFunc' for LSP buffers on LspAttached event fired 
    " omnifunc not ready yet. if &omnifunc != 'g:LspOmniFunc'
        
    " Not an LSP buffer, configure fallback completion
    
    " Add dictionary completion for common file types
    " if &filetype == 'text' || &filetype == 'markdown'
  "     " Set dictionary file if you have one
  "     " set dictionary+=/usr/share/dict/words
  "     setlocal complete+=k  " Add dictionary scanning
    " endif
    
    " Configure completion function for non-LSP buffers, for <C-X><C-u>
    setlocal completefunc=Non_LSP_Complete
    "
    " Set completion options
    setlocal completeopt=menu,menuone,noselect
    setlocal complete=.,w,b,u,t,i  " Current buffer, other windows, other buffers, unloaded buffers, tags, includes
    setlocal shortmess+=c
    
    " idle time to wait for firing CursorHoldI event
    setlocal updatetime=300

    " Setup auto-trigger for this buffer
    augroup FallbackCompletionBuffer
      autocmd! * <buffer>

      " When the user doesn't press a key for the time specified with 'updatetime'.  
      " Not triggered until the user has pressed a key (i.e. doesn't fire every 'updatetime' ms)
      "
      " press a key -> updatetime elapse -> CursorHoldI fire
      autocmd CursorHoldI <buffer> call TriggerFallbackCompletion()
    augroup END
    " endif
endfunction

function! IsFiletypeInLspServers(filetype, lspServers) abort
  for server in a:lspServers
    if (type(server.filetype) == v:t_string && a:filetype ==? server.filetype)
      \ || (type(server.filetype) == v:t_list && index(server.filetype, a:filetype) >=0)
      return 1
    endif
  endfor
  return 0
endfunction

" Custom completion function for non-LSP buffers
function! Non_LSP_Complete(findstart, base)
    if a:findstart
        " Find the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\w\|-\|/\|\.'
          let start -= 1
        endwhile
        return start
    else
        " Get completion items
        let completions = []
        
        " 1. Buffer keyword completion
        let buffer_words = GetBufferWords(a:base)
        call extend(completions, buffer_words)
        
        " 2. File path completion if base contains / or .
        if a:base =~ '[/\\.]'
          let file_completions = GetFileCompletions(a:base)
          call extend(completions, file_completions)
        endif
        
        " 3. Dictionary words (if available), bad idea
        " if !empty(&dictionary)
        "     let dict_words = GetDictionaryWords(a:base)
        "     call extend(completions, dict_words)
        " endif
        
        return completions
    endif
endfunction

" Get words from all buffers matching the base
function! GetBufferWords(base)
    let words = {}
    let pattern = '\<' . escape(a:base, '\') . '\w\+'
    
    " Search in current buffer
    let current_buf = getline(1, '$')
    for line in current_buf
        for word in split(line, '\W\+')
            if word =~? '^' . a:base && len(word) > len(a:base)
              let words[word] = 1
            endif
        endfor
    endfor
    
    " Search in other loaded buffers
    for buf in getbufinfo({'buflisted': 1})
        if buf.bufnr != bufnr('%')
            for line in getbufline(buf.bufnr, 1, '$')
                for word in split(line, '\W\+')
                    if word =~? '^' . a:base && len(word) > len(a:base)
                      let words[word] = 1
                    endif
                endfor
            endfor
        endif
    endfor
    
    return map(sort(keys(words)), '{"word": v:val, "kind": "[Buffer]"}')
endfunction

" Get file path completions
function! GetFileCompletions(base)
    let completions = []
    let glob_pattern = a:base . '*'
    
    try
        let files = glob(glob_pattern, 0, 1)
        for file in files[:50]  " Limit to 50 results
            let item = {
                \ 'word': file,
                \ 'kind': isdirectory(file) ? '[Dir]' : '[File]'
                \ }
            call add(completions, item)
        endfor
    catch
      " Ignore errors
    endtry
    
    return completions
endfunction

" Get dictionary words (if dictionary is set)
function! GetDictionaryWords(base)
    if empty(&dictionary)
      return []
    endif
    
    let words = []
    let pattern = '^' . escape(a:base, '\')
    
    try
        for dict_file in split(&dictionary, ',')
            if filereadable(dict_file)
                let dict_words = readfile(dict_file, '', 100)
                for word in dict_words
                    if word =~? pattern
                      call add(words, {'word': word, 'kind': '[Dict]'})
                    endif
                    if len(words) >= 50
                      break
                    endif
                endfor
            endif
        endfor
    catch
        " Ignore errors
    endtry
    
    return words
endfunction

" Trigger automatic completion for non-LSP buffers
function! TriggerFallbackCompletion()
    " Don't trigger if completion menu is already visible
    if pumvisible()
      return
    endif

    " Get the current line and cursor position
    let line = getline('.')
    let col = col('.') - 1
    
    if col > 0
        let prev_char = line[col - 1]
        
        " Trigger on path characters immediately
        if prev_char =~ '[/\\.]'
          call feedkeys("\<C-X>\<C-u>", 'n')
          return
        endif
        
        " For word characters, need at least 2 consecutive characters
        if prev_char =~ '\w'
            " Count consecutive word characters before cursor
            let word_start = col - 1
            while word_start > 0 && line[word_start - 1] =~ '\w'
              let word_start -= 1
            endwhile
            
            let word_len = col - word_start
            
            " Trigger completion if we have at least 2 characters
            if word_len >= 2
              call feedkeys("\<C-X>\<C-u>", 'n')
            endif
        endif
    endif
endfunction

" inoremap <expr> expects the expression to return a string of keys to be executed. If the expression returns nothing (or v:null), Vim prints 0. Your TriggerManualCompletion() performed feedkeys() but returned nothing — hence 0.
function! TriggerManualCompletionExpr() abort
  if pumvisible()
    " If you want to confirm instead of no-op: return "\<C-y>"
    return ''
  endif

  if IsFiletypeInLspServers(&filetype, g:lspServers)
    " trigger lsp's omni-completion
    call feedkeys("\<C-x>\<C-o>", 'in')
  else
    " trigger non-LSP's completefunc method
    call feedkeys("\<C-x>\<C-u>", 'in')
  endif

  " Must return a string for <expr> mapping
  return ''
endfunction

" Map Ctrl-Space to trigger manual completion
inoremap <silent><expr> <C-Space> TriggerManualCompletionExpr()

" OR
" function! TriggerManualCompletion() abort
"   " If popup menu is already visible, do nothing
"   if pumvisible()
"     return
"   endif
"
"   " Trigger Omni completion (<C-x><C-o>) if this filetype has an LSP server
"   if IsFiletypeInLspServers(&filetype, g:lspServers)
"     " trigger omni-completion (<C-x><C-u>)
"     call feedkeys("\<C-x>\<C-o>", 'in')
"   else
"     " trigger user-defined completion (<C-x><C-u>)
"     call feedkeys("\<C-x>\<C-u>", 'in')
"   endif
" endfunction

" Map Ctrl-Space to trigger manual completion
" Use <C-o> to run an Ex command from Insert mode (no <expr> needed)
" inoremap <silent> <C-Space> <C-o>:call TriggerManualCompletion()<CR>


" use ervandew/supertab instead.
" " Use Tab for cycling through completion menu
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" " Accept completion with Enter
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" builtin completion
" <C-n/p>       Generic keywords
" <C-x><C-n/p>  Current buffer keywords
" <C-x><C-i>    Included file keywords
" <C-x><C-]>    tags file keywords
" <C-x><C-k>    Dictionary lookup
" <C-x><C-l>    Whole line completion
" <C-x><C-f>    Filename completion
" <C-x><C-o>    Omni-completion
" <C-x><C-u>    User defined completion with completefunc option
"
" ervandew/supertab -----------------------------------------------------------------------------
	" -	SuperTab tries to detect context (e.g., method call, filename path, etc) completion.
	" -	If context logic finds “use omni/completefunc”, it will use that.
	" -	If it doesn’t find a match, it uses <c-n/p> (keyword) as fallback.
" let g:SuperTabDefaultCompletionType = 'context'
" context completion's fallback, use keyword completion. 
" while coding, the keyword match you want is typically the closer of the matches above the cursor, which <c-p> naturally provides.
" let g:SuperTabContextDefaultCompletionType = '<c-p>'
"

" UltiSnips ------------------------------------------------------------------------------
"   use <Tab> to expand and jump between snippets
let g:UltiSnipsExpandOrJumpTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
" let g:UltiSnipsListSnippets = '<C-Tab>'

let g:UltiSnipsSnippetDirectories = [
      \ expand(g:vim_data . '/Ultisnips'),
      \ expand(g:vim_data. '/Ultisnips-private')
      \ ]

let g:UltiSnipsEditSplit='vertical'

" auto-pairs -----------------------------------------------------------------------------
"
" builtin auto-pairs shortcuts
" <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
" <BS>  : Delete brackets in pair
" <A-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
" <A-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
" <A-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
" <A-b> : BackInsert (g:AutoPairsShortcutBackInsert)

" Fast wrap the word
" (|)'hello' -> ('hello')
" let g:AutoPairsShortcutFastWrap = '<A-e>'
" let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
" set b:AutoPairs according to filetype, for example, <> is not suitalb
" let g:AutoPairs = {'(':')', '[':']', '{':'}', '<':'>',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
" let g:AutoPairsShortcutBackInsert = '<A-b>'

" vim-surround.vim -----------------------------------------------------------------------------
" ys{motions}{pair}         ys  - You surround   motion: iw/is/ip/f{char},
" yss{pair}                 yss - You surround whole line
" cs{old-pair}{new-pair}    cs  - change surround
" ds{pair}                  ds  - delete surround
"                           pair with extra <SPACE> using (/[/{/<, NO extra <SPACE> using )/]/}/>

" The .command will work with ds, cs, and yss if you install repeat.vim.

" vim-fugitive -----------------------------------------------------------------------------
" Ex commands with arguments is more intuitive than shortcuts in normal mode
noremap <Leader>gg :Git<CR>
" noremap <Leader>gs :Git switch
noremap <Leader>gw :Gwrite<CR>
noremap <Leader>gr :Gread<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gb :Git blame<CR>
" noremap <Leader>gc :Git commit --verbose<CR>
" noremap <Leader>gB :Git rebase -i<CR>
" noremap <Leader>gx :GDelete<CR>
"
" close automatically the buffer created by openning git object using fugitive.
autocmd BufReadPost fugitive://* set bufhidden=delete

" vim-gitgutter ----------------------------------------------------------------------------
" builtin mapping-keys ( g:gitgutter_map_keys )
" changes/hunks navigation, override vim builtin change navigation.
" nmap ]c <Plug>(GitGutterNextHunk)
" nmap [c <Plug>(GitGutterPrevHunk)
"
" <leader>hp    :GitGutterPreviewHunk
" <leader>hs    :GitGutterStageHunk
" <leader>hu    :GitGutterUndoHunk

nnoremap <leader>hd :GitGutterDiffOrig<CR>
nnoremap <leader>hq :GitGutterQuickFix \| copen<CR>
nnoremap <leader>oh :GitGutterToggle<CR>

let g:gitgutter_max_signs = 1024
let g:gitgutter_preview_win_floating = 1

" by default, vimdiff compare buffer (working tree file) against index
" let g:gitgutter_diff_base = '' " or 'HEAD', 'origin/main', '<commit SHA>'
" let g:gitgutter_diff_relative_to = 'index' "  or 'working_tree'
"
" Setting                       Default   Controls                                        Example comparison
" g:gitgutter_diff_base         (empty)    Which commit/tree to compare against            HEAD, origin/main, etc.
" g:gitgutter_diff_relative_to  working_tree Whether to diff working tree or index   index → show staged changes
" -- TL;DR
"   •	gitgutter_diff_base = “Compare against what commit or ref?”
"   •	gitgutter_diff_relative_to = “Compare which version of my file (working tree or index)?”

" ic/ac conflix with builtin comment.vim's textobj
" ic operates on all lines in the current hunk.
" ac operates on all lines in the current hunk and any trailing empty lines.
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" Both plugins use the Vim :sign command under the hood.
" 	•	When GitGutter runs (usually via the BufWritePost or TextChanged autocmd), it calls sign place for changed lines.
" 	•	When yegappan/lsp runs (on receiving diagnostics), it also calls sign place.
" So the last plugin to place signs takes precedence.
let g:gitgutter_sign_priority = 5
" let g:gitgutter_sign_allow_clobber = 0

" vim-bookmarks ----------------------------------------------------------------------------
" don't override built-in mark
let g:bookmark_no_default_key_mappings = 1
nnoremap <Leader>mm :BookmarkToggle<CR>
nnoremap <Leader>mi :BookmarkAnnotate<CR>
nnoremap <Leader>mq :BookmarkShowAll<CR>
nnoremap ]` :BookmarkNext<CR>
nnoremap [` :BookmarkPrev<CR>
nnoremap <Leader>mc :BookmarkClear<CR>
nnoremap <Leader>mx :BookmarkClearAll<CR>

" TaskList.vim ----------------------------------------------------------------------------
nnoremap  <leader>tl <Plug>TaskList
let g:tlWindowPosition = 1
" highlight custom token, like what is done in /usr/share/vim/vim90/syntax/go.vim
" yn keyword     goTodo              contained XX
let g:tlTokenList = ['TODO', 'FIXME', 'XXX', 'BUG', 'FIXIT', 'FIX', 'ERROR', 'WARN']
let g:tlRememberPosition = 1

" vim-floaterm -----------------------------------------------------------------------------
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8
let g:floaterm_opener = 'edit'
let g:floaterm_autoclose = 2

nnoremap   <silent>   <A-3> :FloatermToggle<CR>
nnoremap   <silent>   <A-\> :FloatermToggle<CR>

tnoremap   <silent>   <A-3> <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <A-\> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_keymap_kill   = '<C-d>'
" let g:floaterm_keymap_next   = ']f'
" let g:floaterm_keymap_prev   = '[f'

" ft/floaterm somefile.txt, open files from within :terminal without starting a nested nvim
" Execute git commit in the terminal window without starting a nested vim/nvim.
" :FloatermNew fzf
" :FloatermNew rg

" fatih/vim-go ----------------------------------------------------------------------------

" replace vim-go's lsp functionalities with yegappan/lsp
" | ----------------------------------------------- | ----------------------------- | ------------------------------ | -------------------------------------------------------- |
" | Feature                                         | vim-go (with internal gopls)  | yegappan/lsp (external gopls)  | Notes                                                    |
" | ----------------------------------------------- | ----------------------------- | ------------------------------ | -------------------------------------------------------- |
" | Completion                                      | ✓ (LSP + omnifunc)            | ✓ (via `lsp#complete()`)       | Works fine                                               |
" | Hover / Documentation                           | ✓                             | ✓                              | :LspHover                                                |
" | Go-to-definition / references / implementations | ✓                             | ✓                              | Fully supported                                          |
" | Diagnostics (errors, warnings)                  | ✓                             | ✓                              | Inline and location list                                 |
" | Code actions / quick fixes                      | ✓                             | ✓                              | :LspCodeAction                                           |
" | Rename symbol                                   | ✓                             | ✓                              | :LspRename                                               |
" | Signature help                                  | ✓                             | ✓                              | :LspSignatureHelp                                        |
" | Workspace symbol search                         | ✓                             | ✓                              | :LspWorkspaceSymbols                                     |
" | Semantic tokens (highlighting)                  | ✓                             | ⚠ Partial                      | Vim’s API limits semantic highlighting granularity       |
" | Code Lens                                       | ✓                             | ✓                              | :LspCodeLens                                             | 
" | Inlay Hints                                     | ✓                             | ✓                              | :LspInlayHints                                           |
" | Code formatting                                 | ✓                             | ✓                              | :LspFormat                                               |
" | Auto imports resolution                         | ✓                             | ✓                              | `gopls` handles this behind the scenes                   |
" | Type hierarchy, call hierarchy                  | ⚠  Limited                    | ✓                              | :Lsp***TypeHierarchy / :LspCallHierarchy***              |
" | ----------------------------------------------- | ----------------------------- | ------------------------------ | -------------------------------------------------------- |

" Features that work fine without vim-go’s LSP, implemented using direct Go commands, not the LSP
" | --------------------------------- | ----------------------------------------------------------- | ----------------------------------------------- |
" | Category                          |   Examples                                                  |       Notes                                     |
" | --------------------------------- | ----------------------------------------------------------- | ----------------------------------------------- |
" | Code building & running           |  :GoBuild, :GoRun, :GoTest, :GoTestFunc, :GoInstall, :GoVet | Run Go tools directly                           |
" | Formatting & imports              |  :GoFmt, :GoImports, :GoFmtAutoSave                         | Uses gofmt/goimports binaries                   |
" | Docs & info                       |  :GoDoc, :GoInfo, :GoDescribe                               | Works via go doc, not LSP                       |
" | Code generation                   |  :GoGenerate, :GoModTidy, :GoAddTags                        | Shells out to Go tools                          |
" | Coverage & testing UI             |  :GoCoverage, :GoCoverageClear                              | Works independently                             |
" | Syntax highlighting, folding, etc.|  ftplugin/go.vim and syntax files                           | Built into Vim-go, no LSP needed                |
" | --------------------------------- | ----------------------------------------------------------- | ----------------------------------------------- |
"   -- vim-go comes with an enhanced version of Vim's Go syntax highlighting, except semantic tokens.

let g:go_version_warning = 0

let g:go_code_completion_enabled = 0
let g:go_code_completion_icase = 0

let g:go_auto_type_info = 0
" let g:go_updatetime = 800
"
let g:go_play_open_browser = 0
" let g:go_play_browser_command = '' ['', 'chrome' 'firefox-developer %URL% &' ]

" let g:go_test_show_name = 0
" let g:go_test_timeout= '10s'

let g:go_auto_sameids = 0
" let g:go_jump_to_error = 1

let g:go_fmt_autosave = 0
let g:go_fmt_command = 'goimports'
let g:go_imports_autosave = 0
let g:go_imports_mode = 'goimports'
let g:go_metalinter_autosave = 0
let g:go_metalinter_command = 'golangci-lint'
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_deadline = '5s'
let g:go_mod_fmt_autosave = 0
" let g:go_asmfmt_autosave = 0

" let g:go_fmt_fail_silently = 0
" let g:go_fmt_experimental = 0

" run `godoc` on words under the cursor with |K|, which override the 'keywordprg' setting 
let g:go_doc_keywordprg_enabled = 0
let g:go_doc_max_height = 25
" let g:go_doc_url = 'https://pkg.go.dev'
let g:go_doc_popup_window = 1
" let g:go_doc_balloon = 0

let g:go_def_mode = 'godef'
" Jumps to an existing buffer when Goto [type] declaration/definition.
let g:go_def_reuse_buffer = 1
let g:go_def_mapping_enabled = 1

" let g:go_fillstruct_mode = 'fillstruct'
"
" let g:go_bin_path = ''
" let g:go_search_bin_path_first = 1
let g:go_get_update = 0

let g:go_snippet_engine = 'ultisnips'   " ['automatic', 'ultisnips', 'neosnippet', 'minisnip']

" let g:go_build_tags = ''

" let g:go_textobj_enabled = 1 " if, af, ic, ac
" let g:go_textobj_include_function_doc = 1
" let g:go_textobj_include_variable = 1


" let g:go_list_type = 'quickfix'
let g:go_list_height = 10
" let g:go_list_type_commands = {}
" let g:go_list_type_commands = {'GoBuild': 'locationlist'}
" let g:go_list_autoclose = 1

" terminal for go commands such as :GoRun
let g:go_term_enabled = 1
let g:go_term_mode = 'split'
let g:go_term_reuse = 1
let g:go_term_width = 30
let g:go_term_height = 10
let g:go_term_close_on_exit = 1

" let g:go_alternate_mode = 'edit'

let g:go_rename_command = 'gorename'
let g:go_gorename_prefill = 'expand("<cword>") =~# "^[A-Z]"' .
      \ '? go#util#pascalcase(expand("<cword>"))' .
      \ ': go#util#camelcase(expand("<cword>"))'

" Important: vim-go and yegappan/lsp conflict
" Both plugins can manage their own LSP clients, vim-go has its own internal LSP client for Go
" if you’re using yegappan/lsp, you don’t need vim-go’s built-in LSP
" 	•	both will start gopls independently,
"   •	both will send LSP requests,
"   •	and duplicated messages, hover popups, diagnostics, etc.
"
" by default, gopls is enabled and used by vim-go commands [completion(disabled), format, lint, code_actions ...]
" configure vim-go to share the `gopls` instance with other LSP plugins via 'g:go_gopls_options'
" The commandline arguments to pass to gopls. By default, `['-remote=auto']`.
"
" Option 1 — disable vim-go’s LSP entirely (recommended if using yegappan/lsp)
let g:go_gopls_enabled = 0
"
" Option 2 — use only vim-go’s built-in LSP, disable yegappan/lsp
" let g:go_gopls_enabled = 1

" Option 3 — Share the gopls instance between vim-go and vim-lsp/yegappan/lsp
" gopls supports a -remote option that tells it to reuse a running LSP server if available.
" So when vim-go starts, it will try to connect to that same instance instead of spawning a new one.
" let g:go_gopls_options = ['-remote=auto']

" the config of gopls, ref: https://go.dev/gopls/settings or lsp config in nvim
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
" let g:go_diagnostics_level = 0

" When a new Go file is created, vim-go automatically fills the buffer content
let g:go_template_autocreate = 0
" ${vim-go-home}/template/
" let g:go_template_file = 'hello_world.go'
" let g:go_template_test_file = 'hello_world_test.go'
" OR
let g:go_template_use_pkg = 1

let g:go_decls_includes = 'func,type'
let g:go_decls_mode = 'fzf'

let g:go_echo_command_info = 1
let g:go_echo_go_info = 0
" let g:go_statusline_duration = 60000

" let g:go_addtags_transform = 'snakecase'
" let g:go_addtags_skip_unexported = 0

" let g:go_debug = []

" Control syntax-based folding which takes effect when 'foldmethod' is set to `syntax`.
" set foldmethod=syntax
" let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
"
" vim-go comes with an enhanced version of Vim's Go syntax highlighting, most of which are disabled by default.
" The recommended settings are the default values. 
" If experiencing slowdowns(resource intensive) in Go files and you enabled some of these options then try disabling them.

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1

let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0

" let g:go_highlight_build_constraints = 0
" let g:go_highlight_generate_tags = 0
"
let g:go_highlight_chan_whitespace_error = 1
" let g:go_highlight_array_whitespace_error = 0
" let g:go_highlight_trailing_whitespace_error = 0
"
" let g:go_highlight_space_tab_error = 0
let g:go_highlight_format_strings = 0


let g:go_highlight_string_spellcheck = 0

let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0


" debugger options
" let g:go_debug_windows = {
" \ 'vars':       'leftabove 30vnew',
" \ 'stack':      'leftabove 20new',
" \ 'goroutines': 'botright 10new',
" \ 'out':        'botright 5new',
" \ }

" Contains custom key mapping information to customize the active mappings when debugging.
" Todo: keys only valid for the active mapping, to be updated.
" (the default mappingsm https://github.com/fatih/vim-go/issues/3012)
" "⚠ ", assigning any key to '(go_debug_stop)' doesn't work
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


let g:go_debug_preserve_layout = 1
" let g:go_debug_address = '127.0.0.1:8181'
" An empty string (`''`) will suppress logging entirely.  Default: `'debugger,rpc'`:
" let g:go_debug_log_output = '' ['debugger,rpc']
" let g:go_highlight_debug = 1
let g:go_debug_breakpoint_sign_text = ''
let g:go_debug_current_line_symbol='󰁕'

augroup event_golang
  autocmd!

  autocmd FileType go call <SID>config_go_buf()
augroup END

function! s:config_go_buf() abort

  " :GoInstallBinaries      Download and install all necessary Go tool binaries
  " :GoUpdateBinaries       Download and update previously installed Go tool binaries 
  " :GoPath                 GoPath sets and overrides GOPATH with the given {path}.

  " :GoAddWorkspace [dir]   Add directories to the `gopls` workspace.
  " :GoModFmt               Filter the current go.mod buffer through 'go mod edit -fmt' command.  
  " :GoModReload            Force `gopls` to reload the go.mod file. 

  nnoremap <buffer> <Leader>b :<C-u>call <SID>build_go_files()<CR>
  nnoremap <buffer> <Leader>r  <Plug>(go-run)

  nnoremap <buffer> <Leader>tp <Plug>(go-test)
  nnoremap <buffer> <Leader>tu <Plug>(go-test-func)
  nnoremap <buffer> <Leader>tf <Plug>(go-test-file)

  nnoremap <buffer> <Leader>tc <Plug>(go-coverage)
  nnoremap <buffer> <Leader>tC <Plug>(go-coverage-toggle) 

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

  nnoremap <Leader>ga <Plug>(go-alternate-edit)
  command! -bang -buffer A call go#alternate#Switch(<bang>0, 'edit')
  command! -bang -buffer AV call go#alternate#Switch(<bang>0, 'vsplit')
  command! -bang -buffer AS call go#alternate#Switch(<bang>0, 'split')
  command! -bang -buffer AT call go#alternate#Switch(<bang>0, 'tabe')
  " :GoAlternate         Alternates between the implementation and test code. 

  " ]] -> jump to next function
  " [[ -> jump to previous function

  " Use this option to enable/disable 
  let g:go_def_mapping_enabled = 0
  " gd/<C-]>        :GoDef
  " CTRL-t          :GoDefPop, 
  " gD              :GoDefType.
  " Show the interfaces that the type under the cursor implements.
  
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
  
  nnoremap <buffer> <Leader>ge <Plug>(go-if-err)
  nnoremap <buffer> <Leader>gf <Plug>(go-fill-struct)


  " :GoFillStruct     Use `fillstruct` to fill a struct literal with default values.
  " :GOIfErr          Generate if err != nil { return ... } automatically which infer the type of return values and the numbers.

  " :GoFmt
  " :GoLint           lint code 
  " :GoVet,           catch  static errors 
  " :GoErrCheck,      make sure errors 
  " :GoMetaLinter     call `golangci-lint` to invoke all possible linters (`golint`, `vet`, `errcheck`, `deadcode`, etc.) 

  " Only :GoDebugAttach, :GoDebugStart, :GoDebugTest, and :GoDebugBreakpoint are available by default.
  " The rest of the commands and mappings become available after executing :GoDebugContinue.
  nnoremap <buffer> <F5> :GoDebugStart<CR>
  nnoremap <buffer> <S-F5> <Plug>(go-debug-stop)
  " Someone said 'In practice, TUI Vim is unable to distinguish between <F5>, <S-F5>, and <C-S-F5>, which all send the same character sequence.', but not for sure.
  " autocmd FileType go nnoremap <buffer> <F6> :GoDebugAttach 
  nnoremap <buffer> <F7> :GoDebugTest<CR>
  " GoDebugAttach pid
  " :GoDebugConnect [addr] [default, g:go_debug_address]
  " :GoDebugTest
  " :GoDebugTestFunc
  " :GoDebugRestart  

  " Contains custom key mapping information to customize the active mappings when debugging.
  " Todo: keys only valid for the active mapping, to be updated.
  " (the default mappingsm https://github.com/fatih/vim-go/issues/3012)

  " let g:go_debug_mappings = { ...
  " c         <F5>      :GoDebugContinue
  " <SPACE>   <F8>      :GoDebugHalt
  " b         <F9>      :GoDebugBreakpoint
  " n         <F10>     :GoDebugNext            step over
  " s         <F11>     :GoDebugStep            step in
  " S                   :GoDebugStep            step out
  " p                   :GoDebugPrint
  " q/T
  " *memo: p - print, put cursor on variable and press 'p' to print out the value
  "
  " :GoDebugSet {var} {value}
  " :GoDebugPrint {expr}
endfunction

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files() abort
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" vim-test ----------------------------------------------------------------------------
nnoremap <silent> <leader>tt :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tr :TestLast<CR>
" Visits the test file from which you last run your tests
nnoremap <silent> <leader>tg :TestVisit<CR>
nnoremap <silent> <leader>td :call DebugNearest()<CR>

function! DebugNearest()
  let g:test#go#runner = 'delve'
  TestNearest
  unlet g:test#go#runner
endfunction

" default: basic -- Runs test commands with :! on Vim
let test#strategy = 'dispatch'

" echo the test command before running it
let g:test#echo_command = 1
let test#vim#term_position = 'belowright'
  let g:test#prompt_for_unsaved_changes = 1

" To force a specific runner:
" let test#python#runner = 'pytest' " Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'
" let test#go#runner = 'delve'      " Runners available are 'gotest', 'ginkgo', 'richgo', 'delve'
" let g:test#javascript#runner = 'jest'
" let g:test#rust#runner = 'cargotest'
"
" puremourning/vimspector ----------------------------------------------------------------------------
" Install known gadgets in advance, run ':VimspectorInstall' with no arguments or by plugin manager
let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB', 'delve', 'vscode-js-debug' ]

" :VimspectorInstall <adapter> <args...>
" :VimspectorUpdate to install the latest supported versions of gadgets.

" Vimspector uses vimspector-gadget-directory ( </path/to/vimspector>/gadgets/<os> , by default) 
" to look for a file named '.gadgets.json' to config adapters, which is automatically written by :VimspectorInstall.

" maintain 'configurations' outside of the vimspector repository
" (this can be useful if you have custom gadgets or global configurations), you
" can tell the installer to use a different basedir
" let g:vimspector_base_dir=expand( '$HOME/.vim/dap' )

" All Vimspector configuration is defined in a JSON object. 
" {
"   'adapters': { <object mapping name to <adapter configuration> },
"   'configurations': { <object mapping name to <debug configuration> }
" }

" Vimspector reads a series of files to build the adapters object.
"    - <vimspector home> means the path to the Vimspector installation (such as $HOME/.vim/pack/vimspector/start/vimspector), or the value of g:vimspector_base_dir if that’s set.
"    - <OS> is either macos or linux depending on the host operating system.
"    - <filetype> is the Vim filetype. Where multiple filetypes are in effect, typically all filetypes are checked.
" 1. Adapter configurations
" usually useful to split the adapters configuration into a separate file (or indeed one file per debug adapter).
"   - The contents of g:vimspector_adapters vim variable (dict)
"   - <vimspector home>/gadgets/<OS>/.gadgets.json - the file written by install_gadget.py and not usually edited by users.
"   - <vimspector home>/gadgets/<OS>/.gadgets.d/*.json (sorted alphabetically). These files are user-supplied and override the above.
"   - The first such .gadgets.json file found in all parent directories of the file open in Vim.
"   - The .vimspector.json and any filetype-specific configurations (see below)
" 2. Debug configurations (per-project vs. global per-filetype configurations)
"   - g:vimspector_configurations vim variable (dict)
"   - <vimspector home>/configurations/<OS>/<filetype>/*.json
"   - .vimspector.json in the project source

" Launch(start) or Continue
nmap <leader>ds <Plug>VimspectorContinue
nmap <leader>dc <Plug>VimspectorContinue
" Stop(end)
nmap <leader>de <Plug>VimspectorStop
nmap <leader>dd <Plug>VimspectorRestart
nmap <leader>d<Space> <Plug>VimspectorPause

nmap <leader>db <Plug>VimspectorToggleBreakpoint
nmap <leader>dB <Plug>VimspectorBreakpoints
nmap <leader>dp <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dP <Plug>VimspectorAddFunctionBreakpoint

" reset the current program counter to the current line
nmap <leader>dg <Plug>VimspectorGoToCurrentLine
" p for breakpoint, el punto de interrupción
nmap ]p <Plug>VimspectorJumpToNextBreakpoint
nmap [p <Plug>VimspectorJumpToPreviousBreakpoint
nmap <leader>dj <Plug>VimspectorJumpToProgramCounter

nmap <leader>dr <Plug>VimspectorRunToCursor
nmap <leader>dn <Plug>VimspectorStepOver
nmap <leader>di <Plug>VimspectorStepInto
nmap <leader>do <Plug>VimspectorStepOut
" disAssamble
nmap <leader>da <Plug>VimspectorDisassemble
nmap <leader>dU <Plug>VimspectorUpFrame
nmap <leader>dD <Plug>VimspectorDownFrame

" p for print/eval
nmap <C-p> <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <C-p> <Plug>VimspectorBalloonEval


nnoremap <leader>dC :VimspectorShowOutput Console<CR>
nnoremap <leader>dI :VimspectorDebugInfo<CR>
nnoremap <leader>dL :VimspectorToggleLog<CR>

" Customize vimspector ui
" let g:vimspector_sign_priority = {
"   \    'vimspectorBP':          15,
"   \    'vimspectorBPCond':      15,
"   \    'vimspectorBPLog':       15,
"   \    'vimspectorBPDisabled':  15,
"   \    'vimspectorNonActivePC': 15,
"   \    'vimspectorPC':          999,
"   \    'vimspectorPCBP':        999,
"   \ }

" emmet-vim ----------------------------------------------------------------------------
let g:user_emmet_install_global = 0
" default emmet leader key is <c-y>
" <C-,> is not available on mac m1
let g:user_emmet_leader_key='<C-m>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}
let g:user_emmet_mode='a'    "enable all function in all mode.

" vim-which-key ------------------------------------------------------------------------
" set timeout
set timeoutlen=300
nnoremap <silent> <leader> :<c-u>WhichKey '<leader>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<leader>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  '<localleader>'<CR>
nnoremap <silent> ] :WhichKey ']'<CR>
nnoremap <silent> [ :WhichKey '['<CR>
" Bug: Map <C-w> to trigger which-key
" nnoremap <silent> g :WhichKey 'g'<CR>
" Bug: override gg and other keymaps leaded by g

" let g:which_key_ignore_outside_mappings = 1
let g:which_key_map_normal = {
\ '-': 'split window',
\ '|': 'vsplit window',
\ '/': 'search(buffer)',
\ 'b': 'go build',
\ 'c': 'close',
\ 'C': 'wipeout',
\ 'e': 'eidt',
\ 'n': 'new',
\ 'r': 'go run',
\ 's': 'search(buffers)',
\ 'S': 'live search (grep)',
\ 'w': 'save',
\ 'W': 'save(noautocmd)',
\ 'd': {
\ 'name': '+Debug',
\   ' ': 'pause',
\   'a': 'disassamble(A)',
\   'b': 'breakpoint',
\   'B': 'list breakpoints',
\   'c': 'continue',
\   'C': 'console',
\   'd': 'restart',
\   'D': 'down frame',
\   'e': 'stop/end',
\   'g': 'goto current line',
\   'i': 'step in',
\   'I': 'info',
\   'j': 'jumpto counter',
\   'L': 'log',
\   'n': 'step over(next)',
\   'o': 'step out',
\   'O': 'step out',
\   'p': 'conditional breakpoint',
\   'P': 'function breakpoint',
\   'r': 'run to cursor',
\   's': 'launch',
\   'U': 'up frame',
\ },
\ 'f': {
\ 'name' : '+Fuzzy_Finder',
\  ':': 'history(:)',
\  '/': 'history(/)',
\  "'": 'mark',
\  'b': 'buffer',
\  'c': 'command',
\  'C': 'change',
\  'f': 'file',
\  'g': {
\     'name': '+git',
\     'c': 'commits(buffer)',
\     'C': 'commits(repo)',
\     'f': 'ls-files',
\     's': 'status',
\   },
\  'h': 'helptag',
\  'j': 'jump',
\  'k': 'key',
\  'm': 'mark(buffer)',
\  'M': 'mark',
\  'r': 'history',
\  's': 'snippet',
\  't': 'tag(buffer)',
\  'T': 'tag',
\  'w': 'word',
\  'W': 'window',
\ },
\ 'g': {
\ 'name': '+git/Go',
\   'b': 'git blame',
\   'd': 'git diff',
\   'g': 'git status',
\   'r': 'git read',
\   'w': 'git write',
\   'u': 'git diffupdate',
\   'a': 'go alternate',
\   'e': 'go if-err',
\   'f': 'go fill-struct',
\ },
\ 'h': {
\ 'name' : '+Hunk',
\   'p': 'preview',
\   's': 'stage',
\   'u': 'undo stage',
\   'd': 'diff origin',
\   'q': 'quickfix',
\ },
\ 'm': {
\ 'name' : '+Bookmark',
\   'm': 'toggle',
\   'i': 'annotates',
\   'q': 'show all ',
\   'c': 'clean',
\   'x': 'clean all',
\ },
\ 'o': {
\ 'name' : '+Option',
\   'b': 'background',
\   'c': 'conceal',
\   'h': 'gitgutter',
\   'i': 'inlay hints',
\   'n': 'number',
\   'p': 'paste',
\   's': 'spell',
\   'w': 'wrap',
\ },
\ 't': {
\ 'name': '+Test',
\   't': 'nearest',
\   'u': 'function Unit(go)',
\   'f': 'file',
\   's': 'suite',
\   'r': 'last',
\   'g': 'goto last test',
\   'd': 'debug',
\   'C': 'coverage-toggle(go)',
\   'c': 'coverage(go)',
\   'p': 'package(go)',
\ },
\ 'v': {
\   'name': '+Windows/ventana' ,
\   'w': ['<C-W>w', 'other-window'],
\   'd': ['<C-W>c', 'delete-window'],
\   '-': ['<C-W>s', 'split-window-below'],
\   '|': ['<C-W>v', 'split-window-right'],
\   '2': ['<C-W>v', 'layout-double-columns'],
\   'h': ['<C-W>h', 'window-left'],
\   'j': ['<C-W>j', 'window-below'],
\   'l': ['<C-W>l', 'window-right'],
\   'k': ['<C-W>k', 'window-up'],
\   'H': ['<C-W>5<', 'expand-window-left'],
\   'J': [':resize +5', 'expand-window-below'],
\   'L': ['<C-W>5>', 'expand-window-right'],
\   'K': [':resize -5', 'expand-window-up'],
\   '=': ['<C-W>=', 'balance-window'],
\   's': ['<C-W>s', 'split-window-below'],
\   'v': ['<C-W>v', 'split-window-below'],
\   '?': [ g:fzf_vim.command_prefix . 'Windows' , 'fzf-window'],
\ },
\ 'z': {
\ 'name': '+System',
\   'i': 'lsp info',
\   'l': 'lsp log',
\ }
\}

let g:which_key_map_visual = {
\ 'g' : {
\ 'name' : '+Git',
\ },
\ 'h' : {
\ 'name' : '+Hunk',
\ },
\}

let g:which_key_map_next = {
\  'name' : '+Next' ,
\ ']': 'next function',
\ '%': 'next matchit',
\ '`': 'next bookmark',
\ 'a': 'next argument',
\ 'A': 'last argument',
\ 'b': 'next buffer',
\ 'B': 'last buffer',
\ 'c': 'next change/hunk',
\ 'd': 'next diagnostic ',
\ 'D': 'last diagnostic ',
\ 'l': 'next loclist',
\ 'L': 'last loclist',
\ 'p': 'next breakpoint(P)',
\ 'q': 'next quickfix',
\ 'Q': 'last quickfix',
\ 't': 'next tag',
\ 'T': 'last tag',
\ }

let g:which_key_map_prev = {
\ 'name' : '+Prev' ,
\ '[': 'prev function',
\ '%': 'prev matchit',
\ '`': 'prev bookmark',
\ 'a': 'prev argument',
\ 'A': 'first argument',
\ 'b': 'prev buffer',
\ 'B': 'first buffer',
\ 'c': 'prev change/hunk',
\ 'd': 'prev diagnostic ',
\ 'D': 'first diagnostic ',
\ 'l': 'prev loclist',
\ 'L': 'first loclist',
\ 'p': 'prev breakpoint(P)',
\ 'q': 'prev quickfix',
\ 'Q': 'first quickfix',
\ 't': 'prev tag',
\ 'T': 'first tag',
\ }

let g:which_key_map_g = {
\ 'name' : '+g' ,
\ '%': 'goto matchit',
\ "<LeftMouse>": 'which_key_ignore',
\ 'c': 'comment-toggle',
\ 'C': 'comment-toggle(end)',
\ 'd': 'goto definition',
\ 'D': 'goto declaration',
\ 'O': 'document symbol',
\ 'q': 'format',
\ 's': 'grepper',
\ 'x': 'url-open',
\ "'": {
\   'name': "+Register'"
\   },
\ '`': {
\   'name': '+Register`'
\   },
\ 'r': {
\   'name': '+Lsp',
\   'a': 'code action',
\   'c': 'incoming calls',
\   'C': 'outgoing calls',
\   'd': 'diagnostic here',
\   'h': 'show signature',
\   'n': 'rename',
\   'i': 'goto implement',
\   'I': 'peek implement',
\   'l': 'codelens',
\   'o': 'outline',
\   'q': 'show diagnostics',
\   'r': 'peek references',
\   't': 'goto typedef',
\   }
\ }

" BUG: gc and gcc cann't be re-assign description at same time
" let g:which_key_map_g.c = { 'name': 'comment-toggle', 'c': 'comment-toggle(line)'}

augroup event_which-key
  autocmd!

" To register the descriptions when using the on-demand load feature,
" use the autocmd hook to call which_key#register(), e.g., register for the Space key:
autocmd User vim-which-key call which_key#register(g:mapleader, 'g:which_key_map_normal', 'n')
                       \ | call which_key#register(']', 'g:which_key_map_next', 'n')
                       \ | call which_key#register('[', 'g:which_key_map_prev', 'n')
                       \ | call which_key#register(g:mapleader, 'g:which_key_map_visual', 'v')
                       " \ | call which_key#register('g', 'g:which_key_map_g', 'n')

augroup END

" call which_key#register(g:mapleader, 'g:which_key_map') 
" call which_key#register(g:mapleader, 'g:which_key_map_visual', 'v')
