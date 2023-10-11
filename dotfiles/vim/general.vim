"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
syntax on
filetype plugin indent on    " required

" YouCompleteMe unavailable: requires UTF-8 encoding.
set encoding=utf-8
let &termencoding = &encoding
set fileencodings=utf-8,gbk

if v:version >= 900
  let	g:mapleader = ','
else
  let mapleader = ','
endif
" mapping the reverse character search command to another key.
noremap \ ,

set timeout
set timeoutlen=700

if !exists('$SHELL')
    set shell=/bin/sh
endif


"------------------------------------------------------------------------------
" Files and buffers
"------------------------------------------------------------------------------
"reload file when modified out of vim
set autoread
" writes the content of the file automatically when call :make. vim-go makes use of this option as well.
set autowrite

" change working directories on selecting new files
" set autochdir

" Use Unix as the standard file type
set ffs=unix,mac,dos

"" Enable hidden buffers
set hidden

" no swap, backup and undo files
set nobackup
set noswapfile
set noundofile

"set sub-directories will search for gf, :find command
set path+=**

"------------------------------------------------------------------------------
" Editing

set nopaste
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Don't redraw while executing macros, register and other command without through input (good performance config)
set lazyredraw

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Set command-line completion mode
set complete+=i,k

" Completion options (select longest + show menu even if a single match is found)
set completeopt=longest,menu
" set wildmenu wildchar=<Tab> wildcharm=<C-z>
" set case is ignored when completing file names and directories.
set wildignorecase
set wildmode=list:longest,list:full

" Ignore compiled files
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.sqlite,*.db
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Enable Ctrl-A/Ctrl-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Treat dash-separated words as a word text object
set iskeyword+=-

" default: tcqj, 
" o -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode. 
" a -- Automatic formatting of paragraphs.
set formatoptions="jtcrqlnwmp" 
"------------------------------------------------------------------------------
" Search & Replace
" 'ignorecase' and 'smartcase' options be set to ignore case when the pattern contains lowercase letters only.
set ignorecase
set smartcase

" When doing keyword completion in insert mode, and 'ignorecase' is also on,
" the case of the match is adjusted depending on the typed text.  I
set infercase

" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch

" overwrite vim' grep command output on Unix: grep -n $* /dev/null
" vim/nvim will collect result from external grepprg's standard output.
set grepprg=grep\ -n
set grepformat=%f:%l:%m

"------------------------------------------------------------------------------
" Editor UI
"------------------------------------------------------------------------------
set title
set titleold="Terminal"
set titlestring=%F

" Highlight current line - allows you to track cursor position more easily
set cursorline

" Show line, column number, and relative position within a file in the status line
set ruler
set number
set relativenumber

" modelines allow you to set variables specific to a file, like /* vim: tw=60 ts=2: */ in .c or other language file.
set modeline

set foldmethod=syntax
set foldlevel=10
set foldnestmax=10
set foldcolumn=0

" default 8 characters, https://www.kernel.org/doc/html/v4.10/process/coding-style.html
" don't use spaces instead of tabs
set noexpandtab
set smarttab
" show tab and space with different chars. toggle it using :set invlist
" set list
" set listchars=tab:>~,space:_

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround
set autoindent
set smartindent

set nowrap "Don't Wrap lines (it is stupid, except raw document or markdown.)
set whichwrap+=[,],<,>,h,l
set colorcolumn=""

" Always show the status line
set laststatus=2
set showcmd
" set cmdheight=1
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"------------------------------------------------------------------------------

" DON'T use newtab: fugitive.vim's :Gclog and Ggrep will open new buffers in the new tabs when switchbuf include newtab.
" set switchbuf=useopen,usetab,newtab
set switchbuf=uselast,useopen
set showtabline=1  " default 1, tab page labels only if there are at least two tab pages

" don't change the default posistion of new window split by fugitive.vim
" set splitbelow
" set splitright

"------------------------------------------------------------------------------
" misc:
set nospell
" set spelllang=en_ca
" set spelllang=fr
" set dictionary=/usr/share/dict/words,/usr/share/dict/words
" setlocal spellfile+=~/.dict/spellfile/fr.utf-8.add

" recall commands from history in Command-line (Ex) mode
set history=2000

" set helplang=cn             "help file in chinese

"------------------------------------------------------------------------------
" key mapping (map commands)and abbreviations
"------------------------------------------------------------------------------
" temporarily enable for debugging vim config file
" noremap <silent> <leader>sv :source $MYVIMRC<cr>

" Disable arrowskeys and force to forget the mapping (trick)
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" -- buffers  -----------------------------------
" Opens an edit command with the path of the currently edited file filled in
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <cr>
nnoremap <silent> <leader>w :w<cr>

cnoreabbrev W! w!
" sudo write readonly file
cnoremap <leader>sw w !sudo tee >/dev/null %

nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>
" don't overwrite <c-n> <c-p> in fugitive.vim
" nnoremap <c-n> :bnext<cr>
" nnoremap <c-p> :bprevious<cr>
nnoremap ]B :blast<cr>
nnoremap [B :bfirst<cr>


" The :Bclose command deletes a buffer without changing the window layout.
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>x :Bclose<CR>

" -- windows  -----------------------------------
" window commands prefixing with CTRL-W is quite good.

" :only, close all windows except the current one
nnoremap <leader>o <c-w><c-o>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

inoremap <c-h> <c-\><c-n><c-w>h
inoremap <c-j> <c-\><c-n><c-w>j
inoremap <c-k> <c-\><c-n><c-w>k
inoremap <c-l> <c-\><c-n><c-w>l

tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l


" map | and - to split window
noremap <leader>\| :vsplit<cr>
noremap <leader>- :split<cr>

" Should disable ^<-, ^->, ^↑, ^↓ in MissionControl shortcuts (macos)
noremap <C-Up> :resize -2<CR>
noremap <C-Down> :resize +2<CR>
noremap <C-Left> :vertical resize -5<CR>
noremap <C-Right> :vertical resize +5<CR>

" ZZ(:x), built-in Command, svae current buffer and quit the current window, and quit in case is the last edit-window.
" same as ZZ except refuseing to abandonthe current buffer which has been edited.
" TODO: call <leader>q to quit popup windows (like terminal in popup windows) as well.
nnoremap <silent> <leader>q :Wclose<cr>
command! -bang -nargs=? Wclose call <SID>Wclose(<q-bang>, <q-args>)
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq


" -- tabs  -----------------------------------
" built-in gt/gT for :tabnext/tabprev
nnoremap ]t :tabnext<cr>
nnoremap [t :tabprevious<cr>
nnoremap ]T :tablast<cr>
nnoremap [T :tabfirst<cr>

" -- quickfix  -----------------------------------
" nnoremap <leader>cc :botright copen<cr>
nnoremap <silent> <leader>qq :call <SID>ToggleQuickfix(0)<cr>

nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]Q :clast<cr>
nnoremap [Q :cfirst<cr>

nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]L :llast<cr>
nnoremap [L :lfirst<cr>

" -- editing  -----------------------------------
"" move selected lines up or down
vnoremap <leader>j :m '>+1<cr>gv=gv
vnoremap <leader>k :m '<-2<cr>gv=gv
vnoremap <silent> p P
" Use built-in do & dp
" do (diff obtain) for :diffget (modify the current buffer to undo difference with another buffer)
" dp (diff put) for :diffput (modify another buffer to undo difference with the current buffer)

" Toggle paste mode on and off
" When the ‘paste’ option is enabled, 
" Vim turns off all Insert mode mappings, abbreviations and resets a host of options, including ‘autoindent’
" That allows us to safely paste from the system clipboard with no surprises.
" map <C-p> :setlocal paste!<cr>

" clear highlight, <C-Enter>, On macOS, used as default shortcut for sending a newline in many applications.
" nnoremap <silent> <Esc> :<C-u>nohlsearch<cr>
" nnoremap <Esc><Esc> :nohlsearch<cr>
nnoremap <Esc> :nohlsearch<cr>

" search for the current selection In Visual and Select mode using * and #
" same as * and # for searching the word under current cursor In normal mode.
xnoremap * :<C-u>call <SID>VSetSearch()<cr>/<C-R>=@/<cr><cr>
xnoremap # :<C-u>call <SID>VSetSearch()<cr>?<C-R>=@/<cr><cr>

" Execute last substitute
" The & command is a synonym for :s, which repeats the last substitution. Unfortunately, 
" if any flags were used, the & command disregards them.
" Making & trigger the :&& command is more useful. It preserves flags and therefore produces more consistent results.
nnoremap & :&&<cr>
xnoremap & :&&<cr>

" call make silently
cnoreabbrev <expr> make 'silent make \| redraw!'
" rewrite grep command to run silently without press Enter to continue.
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep': 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'

nnoremap <leader>b :make<cr>
" Qargs populates the argument list with each files name in the quickfix list (generated by :vimgrep or :make)
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

""------------------------------------------------------------------------------
" Command-mode related
"for easily invoke up Command Window
cnoremap <C-o> <C-f>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" type %% on Vim’s ':' command-line prompt, automatically expands to the directory of the active buffer
" :edit %%, :read %%, :write %%, save %%, saveas %%.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
"------------------------------------------------------------------------------

" built-in terminal emulation
if v:version >= 800
  nnoremap <silent> <leader>ts :terminal <cr>
  nnoremap <silent> <leader>tv :vertical terminal<cr>
endif

" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
" <C-v> means Verbatim. <C-v><Esc> send an Escape key to the program running inside the terminal buffer.
tnoremap <C-v><Esc> <Esc>
" To simulate |i_CTRL-R| in terminal-mode:
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <silent> <leader>q <c-\><c-n>:Wclose<cr>

"" Switching Windows, Terminal mode under neovim
" toggle spell checking
" nnoremap <C-s> :setlocal spell!<cr>

iabbrev adn and
iabbrev waht what
iabbrev @@    m.zhujiang@gmail.com
iabbrev ccopy Copyright 2017 Jiang Zhu, all rights reserved.
"------------------------------------------------------------------------------
" Events Handlers
"------------------------------------------------------------------------------
augroup event_filetype
  autocmd!
  " Remember cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " autocmd BufWinEnter * :highlight ExtraWhitespace ctermbg=yellow guibg=yellow | match ExtraWhitespace /\s\+$/
  " autocmd BufWinLeave * call clearmatches()

  autocmd BufNewFile,BufReadPost *.txt,*.md set spell!

  autocmd BufNewFile,BufReadPost *.xprofile,*.xshrc		set filetype=sh
  autocmd BufNewFile,BufReadPost *.gradle set filetype=groovy
  autocmd BufNewFile,BufReadPost *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufReadPost *.handlebars set filetype=html
  autocmd BufNewFile,BufReadPost CMakeLists.txt setlocal filetype=cmake
  autocmd BufNewFile,BufReadPost *.gohtml set filetype=gohtmltmpl

  autocmd FileType markdown set wrap | set linebreak
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
  autocmd FileType java,groovy :execute "compiler gradle"
  autocmd FileType shell,python set commentstring=#\ %s
  " autocmd FileType html,css,javascript,typescript EmmetInstall

  " buflisted option, the buffer shows up in the buffer list. Exclude quickfix buffer from `:bnext` `:bprevious`
  autocmd FileType qf,goterm set nobuflisted

augroup END

augroup event_term
  if v:version >= 800
      " autocmd TerminalOpen * if &buftype == 'terminal' | :startinsert | endif
      autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
      " autocmd BufLeave * if &buftype == 'terminal' | silent! stopinsert | endif
      " TODO:wait for WinClosed event available in coming version vim 8.2.3591
      if v:versionlong >= 8023591
        autocmd WinClosed * if &buftype == 'terminal' | bdelete! | endif
      endif
  endif
augroup END

augroup event_completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewLeader && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup event_quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow

  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
augroup END

augroup event_tab
  autocmd!
  " Let 'tl' toggle between this and the last accessed tab
  let g:lasttab = 1
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

"------------------------------------------------------------------------------
" Helper Functions
"------------------------------------------------------------------------------
function s:Wclose(bang, win)
  " let window_count = winnr('$')
  " let prev_window = winnr('#')
  " let wnum = winnr('3k')
  if empty(a:win)
    let wtarget = winnr()
  elseif a:win =~ '^\d\+$'
    let wtarget = winnr(str2nr(a:win))
  else
    let wtarget = winnr(a:win)
  endif

  if wtarget < 0
    call s:Warn('No matching window for '.a:win)
    return

  elseif wtarget == 0  " popup window
    let btarget = winbufnr(wtarget)
    let filetype = getbufvar(btarget, '&filetype')
    if filetype == 'floaterm'
      let bname = bufname(btarget)
      call floaterm#kill(0, btarget, bname)
      return
    else
      " TODO: to stop jobs before close popup window as floaterm does.
      call popup_clear(1)
    endif
  else
    if winnr('$') == 1
      quit
    else
      execute wtarget.'wincmd c'
    endif
  endif
endfunction


" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
let bclose_multiple = 1  " close a buffer even if it is displayed in multiple windows 
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif

  " TODO: to deal with filetype == 'gitcommit'
  if getbufvar(btarget, '&filetype') == 'gitcommit'
    " write comment and quit window
    execute 'wq'
    return 
  endif 

  if empty(a:bang) && getbufvar(btarget, '&modified')
    " TODO: buftype -- nofile nowrite acwrite quickfix help terminal propt pop
    if getbufvar(btarget, '&buftype') == 'terminal' 
      return
    else
      call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    endif 
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction


" Quickfix
function! s:ToggleQuickfix(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    botright copen
    " copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction