" *****************************************************************************
" Vim-PLug 
let vimplug_exists=expand(g:vim_home. '/autoload/plug.vim')
let curl_exists=expand('curl')

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
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
" Make sure you use single quotes
call plug#begin(g:vim_data . '/plugged')
  " Try load plugins lazily as possible

  " colorscheme
  " Plug 'altercation/vim-colors-solarized'
  " Plug 'morhetz/gruvbox'
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


  " Plug 'Exafunction/windsurf.vim'

  " LSP features: Code completion, format, lint ...
  Plug 'yegappan/lsp'

  " a suite consist of supertab, asyncomplete and ultisnips
  " Async completion engine and sources
  Plug 'prabirshrestha/asyncomplete.vim'
  " yegappan/lsp acts as lsp completion source for asyncomplete
  " Plug 'prabirshrestha/asyncomplete-lsp.vim' 
  Plug 'prabirshrestha/asyncomplete-buffer.vim'
  Plug 'prabirshrestha/asyncomplete-emmet.vim'
  " https://github.com/high-moctane/asyncomplete-nextword.vim?tab=readme-ov-file
  " Plug 'high-moctane/asyncomplete-nextword.vim'
  Plug 'prabirshrestha/asyncomplete-file.vim'
  Plug 'laixintao/asyncomplete-gitcommit'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
  Plug 'ervandew/supertab'

  " " insert or delete brackets, parens, quotes in pair under Insert mode
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  " Repeat.vim remaps . in a way that plugins can tap into it.
  Plug 'tpope/vim-repeat'

  " Aligning text
  Plug 'godlygeek/tabular', { 'on': 'Tabularize'}

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

  " ****** Custom Language bundles ****************************************************
  " Golang Bundle --------------------------------------------------------------------
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go'}

  " Bundle ----------------------------------------------------------------------
  " Plug 'rust-lang/rust.vim', { 'for': 'rust'}

  "" /css/Javascript Bundle -----------------------------------------------------
  Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript','typescript']}
  Plug 'AndrewRadev/tagalong.vim', {'for': ['html', 'jsx', 'javascript','typescript', 'xml']}

  " define keymap centralized and help to memerize
  " Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

  "" Include user's extra bundle
  if filereadable(expand(vim_home . "/.vimrc.local"))
    source vim_home . "/.vimrc.local"
  endif
call plug#end()

" -------------------------------------------------------------------------------
" colorscheme

if &runtimepath =~ 'everforest'
  " Important!!
  if has('termguicolors')
    set termguicolors
  endif
  
  let g:everforest_background = 'soft' " 'hard', 'medium'(default), 'soft'
  " let g:everforest_enable_italic = 1
  " let g:everforest_disable_italic_comment = 1
  " let g:everforest_cursor = 'auto'
  " let g:everforest_transparent_background = 0
  " let g:everforest_spell_foreground = 'none'
  " let g:everforest_show_eob = 0
  " let g:everforest_sign_column_background = 'none'
  " let g:everforest_ui_contrast = 'low'
  " let g:everforest_show_eo = 1
  " let g:everforest_float_style = 'bright'
  " let g:everforest_diagnostic_text_highlight = 1
  " let g:everforest_diagnostic_line_highlight = 1
  " let g:everforest_diagnostic_virtual_text = 'grey' " 'colored' 'highlighted'
  " let g:everforest_current_word = 'grey background'
  " let g:everforest_lightline_disable_bold = 1
  " let g:everforest_current_word = 'grey background'
  " let g:everforest_inlay_hints_background = 'none'
  " let g:everforest_disable_terminal_colors = 0
  " let g:everforest_lightline_disable_bold = 1
  let g:everforest_better_performance = 1
  " let g:g:everforest_colors_override = {}
  
  " configuration option should be placed before `colorscheme everforest`.
  silent! colorscheme everforest
elseif &runtimepath =~ 'vim-colors-solarized'
  let g:solarized_termcolors=256
  silent! colorscheme solarized
elseif &runtimepath =~ 'gruvbox'
  silent! colorscheme gruvbox
endif

"------------------------------------------------------------------------------
" " vim-airline
let g:airline_experimental = 1

" let g:airline_theme='deus'
let g:airline_theme='everforest'
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

let g:airline_extensions = ['branch', 'tabline', 'vim9lsp', 'hunks']
" Smarter tab line
let g:airline#extensions#tabline#enabled = 0          " set showtabline=2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'default'
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'b'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
" let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

let g:airline#extensions#vim9lsp#enabled = 0
let g:airline#extensions#vim9lsp#error_symbol = ' '
let g:airline#extensions#vim9lsp#warning_symbol = ' '

" -----------------------------------------------------------------------------
" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_no_status_line = 1
" let g:tagbar_position = 'leftabove'

" ------------------------------------------------------------------------------
" vim-grepper
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']
" Search for the current word
nnoremap <Leader>fw :Grepper -cword -noprompt<CR>
" Search for the current selection, gs{motion}, {selection}gs
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" ------------------------------------------------------------------------------
"" fzf.vim 
if executable('fd')
  let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
endif

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
      \ 'b': 'Buffers',
      \ 'c': 'Commands',
      \ 'C': 'Changes',
      \ 'e': 'Rg',
      \ 'f': 'Files',
      \ 'gc': 'BCommits',
      \ 'gC': 'Commits',
      \ 'gf': 'GFiles(git ls-files)',
      \ 'gs': 'GFiles?(git status)',
      \ 'h': 'Helptags',
      \ 'j': 'Jumps',
      \ 'k': 'Keymaps',
      \ 'l': 'BLines',
      \ 'L': 'Lines',
      \ 'm': 'Marks',
      \ 'r': 'Oldfiles',  
      \ 's': 'Snippets',
      \ 'S': 'Colors', 
      \ 't': 'BTags',
      \ 'T': 'Tags',
      \ 'w': 'Windows',
      \ }

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

" override builtin complete (word, path,line)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" ------------------------------------------------------------------------------
" LSP client (yegappan/lsp) for Vim 9+
"
" Enable LSP logging (optional for debugging)
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('${HOME}/local/state/vim/lsp.log')

let lspOpts = #{
  \   autoHighlightDiags: v:true,
  \   showDiagInPopup: v:true,
  \   showDiagInBalloon: v:false,
  \   showDiagOnStatusLine: v:true,
  \   showDiagWithVirtualText: v:false,
  \   diagSignErrorText: " ",
  \   diagSignHintText: " ",
  \   diagSignInfoText: " ",       
  \   diagSignWarningText: " ",
  \   diagVirtualTextAlign: 'after',
  \   hideDisabledCodeActions: v:true, 
  \   outlineOnRight: v:true,
  \   popupBorder: v:true,
  \   popupBorderSignatureHelp: v:true,
  \   semanticHighlight: v:true,
  \   ultisnipsSuppor	: v:false,		
  \   usePopupInCodeAction: v:true,    
  \   useQuickfixForLocations: v:true,	
  \   filterCompletionDuplicates: v:true, 
  \ }

highlight LspDiagVirtualText ctermfg=Cyan guifg=Blue
" highlight link LspDiagLine DiffAdd
" highlight link LspDiagVirtualText WarningMsg

autocmd User LspSetup call LspOptionsSet(lspOpts)

" \   syncInit: v:true,
let lspServers = [#{
	\	  name: 'golang',
	\	  filetype: ['go', 'gomod'],
  \   path: trim(system('which gopls')), 
  \   args: ['serve'],
  \   rootSearch: [ 'go.work', 'go.mod', '.git' ],
	\ }, #{
	\	  name: 'clang',
	\	  filetype: ['c', 'cpp'],
  \   path: trim(system('which clang')), 
	\	  args: ['--background-index'],
  \   rootSearch: [ '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', 'compile_commands.json', 'compile_flags.txt', '.git' ],
	\ },
  \ #{ name: 'rustlang',
	\    filetype: ['rust'],
  \    path: trim(system('which rust-analyzer')), 
	\    args: [],
	\    syncInit: v:true,
  \   rootSearch: [ 'Cargo.toml', '.git' ],
	\ },
  \ #{
	\    name: 'typescriptlang',
	\    filetype: ['javascript', 'typescript'],
  \    path: trim(system('which typescript-language-server')), 
	\    args: ['--stdio'],
  \    rootSearch: [ 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' ],
	\ }]

" A User autocommand fired when the LSP plugin is loaded.
autocmd User LspSetup call LspAddServer(lspServers)
" A User autocommand fired when the LSP client attaches to a buffer.
" autocmd User LspAttached 
" A User autocommand invoked when new diagnostics are received from the language server.
" autocmd User LspDiagsUpdated

" colorscheme should clear SignColumn highlight
" highlight clear SignColumn

" Optional keymaps for LSP actions
nnoremap <silent> gd    :LspGotoDefinition<CR>
nnoremap <silent> <C-]> :LspGotoDefinition<CR>
nnoremap <silent> gD    :LspGotoDeclaration<CR>

nnoremap <silent> K   :LspHover<CR>
nnoremap <silent> grr :LspPeekReferences<CR>
nnoremap <silent> gri :LspGotoImpl<CR>
nnoremap <silent> grI :LspPeekImpl<CR>
nnoremap <silent> grt :LspGotoTypeDef<CR>
nnoremap <silent> gO  :LspDocumentSymbol<CR>
nnoremap <silent> gro :LspOutline<CR>


nnoremap <silent> grc :LspIncomingCalls<CR>
nnoremap <silent> grC :LspOutgoingCalls<CR>

nnoremap <silent> [d :LspDiag prev<CR>
nnoremap <silent> ]d :LspDiag next<CR>
nnoremap <silent> [D :LspDiag first<CR>
nnoremap <silent> ]D :LspDiag last<CR>
nnoremap <silent> <C-k>   :LspDiag current<CR>
nnoremap <silent> <C-w>d  :LspDiag current<CR>
nnoremap <silent> grd :LspDiag current<CR>
nnoremap <silent> grq :LspDiag show<CR>

nnoremap <silent> gq :LspFormat<CR>

nnoremap <silent> grn :LspRename<CR>
nnoremap <silent> gra :LspCodeAction<CR>
nnoremap <silent> grl :LspCodeLens<CR>

nnoremap <silent> grh :LspShowSignature<CR>
inoremap <silent> <C-S> :LspShowSignature<CR>

" lsp info
nnoremap <silent> <leader>zi :LspShowAllServers<CR>
" lsp log
nnoremap <silent> <leader>zl :LspServer show messages<CR>

" Auto-format before saving using vim-lsp
" function! s:LspFormatAndLint() abort
  " Check if an LSP server is attached to this buffer
  " if !lsp#is_server_running_for_buffer()
  
"   " Check if any LSP client is attached
"   if empty(lsp#get_buffer_servers())
"     return
"   endif
"
"   " Format if supported
"   if lsp#utils#supports_method('textDocument/formatting')
"     echom '⏳ Formatting via LSP...'
"     call lsp#formatting_sync(1000)
"   endif
"
"   echom '✔ Format + lint done'
" endfunction
"
" augroup LspFormatOnSave
"   autocmd!
"   " For all files
"   " autocmd BufWritePre * call s:LspFormatAndLint()
"   " Or restrict to certain languages if you prefer:
"   autocmd BufWritePre *.go,*.py,*.ts,*.rs call s:LspFormatAndLint()
" augroup END

autocmd BufWritePre *.go,*.py,*.ts,*.rs silent! LspFormat
" ------------------------------------------------------------------------------
"  asyncomplete.vim 

" override omnifunc with LSP completion
autocmd FileType c,c++,go,rust,python,javascript,typescript setlocal omnifunc=lsp#complete

" Configure asyncomplete to use the LSP source
def s:Asyncomplete_register_sources()
  call asyncomplete#register_source({
    \ 'name': 'lsp',
    \ 'whitelist': ['*'],
    \ 'completor': function('lsp#complete'),
    \ }) 

  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

  call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({ 
    \ 'name': 'emmet',
    \ 'whitelist': ['html'],
    \ 'completor': function('asyncomplete#sources#emmet#completor'),
    \ }))

  call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

  call asyncomplete#register_source({
    \ 'name': 'gitcommit',
    \ 'whitelist': ['gitcommit'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#gitcommit#completor')
    \ })

  if has('python3')
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
  endif
enddef

augroup AsyncompleteLsp
  autocmd!
  autocmd User asyncomplete_setup call s:Asyncomplete_register_sources()
augroup END

" For inline completion like copilot-language-server, set keys to 
" g:asyncomplete_lsp_inline_complete_accept_key.

" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" ------------------------------------------------------------------------------
" 'ervandew/supertab'
" while coding, the keyword match you want is typically the closer of the matches above the cursor, which <c-p> naturally provides.
" let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

"------------------------------------------------------------------------------
" UltiSnips
"   use <Tab> to expand and jump between snippets
let g:UltiSnipsExpandOrJumpTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
" let g:UltiSnipsListSnippets = '<C-Tab>'

let g:UltiSnipsSnippetDirectories = [
      \ expand(g:vim_data . '/Ultisnips'),
      \ expand(g:vim_data. '/Ultisnips-private')
      \ ]

let g:UltiSnipsEditSplit="vertical"

" ------------------------------------------------------------------------------
" auto-pairs
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

" ------------------------------------------------------------------------------
" vim-surround.vim
" ys{motions}{pair}         ys  - You surround   motion: iw/is/ip/f{char},
" yss{pair}                 yss - You surround whole line
" cs{old-pair}{new-pair}    cs  - change surround
" ds{pair}                  ds  - delete surround
"                           pair with extra <SPACE> using (/[/{/<, NO extra <SPACE> using )/]/}/>

" The .command will work with ds, cs, and yss if you install repeat.vim.

" ------------------------------------------------------------------------------
" vim-fugitive

" Ex commands with arguments is more intuitive than shortcuts in normal mode
noremap <Leader>gg :Git<CR>
" noremap <Leader>gs :Git switch
" noremap <Leader>gw :Gwrite<CR>
" noremap <Leader>gr :Gread<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gb :Git blame<CR>
" noremap <Leader>gc :Git commit --verbose<CR>
" noremap <Leader>gB :Git rebase -i<CR>
" noremap <Leader>gx :GDelete<CR>
"
" close automatically the buffer created by openning git object using fugitive.
autocmd BufReadPost fugitive://* set bufhidden=delete

" -----------------------------------------------------------------------------
" vim-gitgutter
" builtin mapping-keys ( g:gitgutter_map_keys )
" changes/hunks navigation, override vim builtin change navigation.
" nmap ]c <Plug>(GitGutterNextHunk)
" nmap [c <Plug>(GitGutterPrevHunk)
"
" <leader>hp    :GitGutterPreviewHunk  
" <leader>hs    :GitGutterStageHunk
" <leader>hu    :GitGutterUndoHunk

nnoremap <leader>hd :GitGutterDiffOrig<cr>
nnoremap <leader>hq :GitGutterQuickFix \| copen<cr>
nnoremap <leader>oh :GitGutterToggle<cr>

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

" -----------------------------------------------------------------------------
" vim-bookmarks
" don't override built-in mark
let g:bookmark_no_default_key_mappings = 1
nnoremap <Leader>mm :BookmarkToggle<cr>
nnoremap <Leader>mi :BookmarkAnnotate<cr>
nnoremap <Leader>mq :BookmarkShowAll<cr>
nnoremap ]` :BookmarkNext<cr>
nnoremap [` :BookmarkPrev<cr>
nnoremap <Leader>mc :BookmarkClear<cr>
nnoremap <Leader>mx :BookmarkClearAll<cr>

" -----------------------------------------------------------------------------
" TaskList.vim
map <leader>tl <Plug>TaskList
let g:tlWindowPosition = 1
" highlight custom token, like what is done in /usr/share/vim/vim90/syntax/go.vim
" yn keyword     goTodo              contained XX
let g:tlTokenList = ['TODO', 'FIXME', 'XXX', 'BUG', 'FIXIT', 'FIX', 'ERROR', 'WARN']
let g:tlRememberPosition = 1

" ------------------------------------------------------------------------------
" vim-floaterm
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

" -----------------------------------------------------------------------------
" Golong, vim-go
let g:go_version_warning = 0

let g:go_code_completion_enabled = 0
let g:go_code_completion_icase = 0

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
let g:go_doc_keywordprg_enabled = 1
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
let g:go_def_mapping_enabled = 1

" let g:go_bin_path = ''
" let g:go_search_bin_path_first = 1
let g:go_get_update = 0

let g:go_snippet_engine = 'automatic' " ['automatic', 'ultisnips', 'neosnippet', 'minisnip']


" let g:go_build_tags = ''

" let g:go_textobj_enabled = 1 " if, af, ic, ac
" let g:go_textobj_include_function_doc = 1
" let g:go_textobj_include_variable = 1

let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave = 0
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
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

" let g:go_alternate_mode = 'edit'

" let g:go_rename_command = 'gopls'
let g:go_gorename_prefill = 'expand("<cword>") =~# "^[A-Z]"' .
      \ '? go#util#pascalcase(expand("<cword>"))' .
      \ ': go#util#camelcase(expand("<cword>"))'

" by default, gopls is enabled and used by vim-go commands [completion(disabled), format, lint, code_actions ...]
" configure vim-go to share the `gopls` instance with other LSP plugins via 'g:go_gopls_options'
" The commandline arguments to pass to gopls. By default, `['-remote=auto']`.
" let g:go_gopls_enabled = 1
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
let g:go_diagnostics_level = 0
" let g:go_diagnostics_enabled = 0 , " Deprecated.

" When a new Go file is created, vim-go automatically fills the buffer content
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

" let g:go_highlight_types = 1
" let g:go_highlight_functions = 1

" let g:go_highlight_function_parameters = 0
" let g:go_highlight_function_calls = 0

" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1

" let g:go_highlight_build_constraints = 0
" let g:go_highlight_generate_tags = 0
" let g:go_highlight_chan_whitespace_error = 0
" let g:go_highlight_array_whitespace_error = 0
" let g:go_highlight_space_tab_error = 0
" let g:go_highlight_trailing_whitespace_error = 0
" let g:go_highlight_format_strings = 1
" let g:go_highlight_variable_declarations = 0
" let g:go_highlight_variable_assignments = 0

" let g:go_highlight_string_spellcheck = 0

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
let g:go_debug_breakpoint_sign_text = ''
let g:go_debug_current_line_symbol='󰁕'

augroup event_golang
  autocmd!
  " :GoInstallBinaries      Download and install all necessary Go tool binaries
  " :GoUpdateBinaries       Download and update previously installed Go tool binaries 
  " :GoPath                 GoPath sets and overrides GOPATH with the given {path}.

  " :GoAddWorkspace [dir]   Add directories to the `gopls` workspace.
  " :GoModFmt               Filter the current go.mod buffer through 'go mod edit -fmt' command.  
  " :GoModReload            Force `gopls` to reload the go.mod file. 

  autocmd FileType go nnoremap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nnoremap <buffer> <leader>r  <Plug>(go-run)

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

  autocmd FileType go nnoremap <A-f> <Plug>(go-alternate-edit)
  autocmd Filetype go command! -bang -buffer A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang -buffer AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang -buffer AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang -buffer AT call go#alternate#Switch(<bang>0, 'tabe')
  " :GoAlternate         Alternates between the implementation and test code. 

  " ]] -> jump to next function
  " [[ -> jump to previous function

  " 'K' normally runs the `man` program, but for Go using `godoc` is more idiomatic.
  " autocmd FileType go nnoremap <buffer> K <Plug>(go-doc)

  " Use this option to enable/disable 
  " gd/<C-]>        :GoDef
  " CTRL-t          :GoDefPop, 
  " gD              :GoDefType.
  let g:go_def_mapping_enabled = 1
  " Show the interfaces that the type under the cursor implements.
  autocmd FileType go nnoremap <buffer> <leader>gi <Plug>(go-implements)
  autocmd FileType go nnoremap <buffer> <leader>grs <Plug>(go-callstack)
  autocmd FileType go nnoremap <buffer> <leader>grp <Plug>(go-channel-peers)
  " autocmd FileType go nnoremap <buffer> <leader>grr <Plug>(go-referrers)
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

  " Assigning any key to '(go_debug_stop)' doesn't work
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
" vim-test
nnoremap <silent> <leader>tt :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ta :TestSuite<CR>
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
let test#strategy = "dispatch"

" echo the test command before running it
let g:test#echo_command = 1
let test#vim#term_position = "belowright"
  let g:test#prompt_for_unsaved_changes = 1

" To force a specific runner:
" let test#python#runner = 'pytest' " Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'
" let test#go#runner = 'delve'      " Runners available are 'gotest', 'ginkgo', 'richgo', 'delve'
" let g:test#javascript#runner = 'jest'
" let g:test#rust#runner = 'cargotest'

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
let g:user_emmet_mode='a'    "enable all function in all mode.
