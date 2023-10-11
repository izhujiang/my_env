" minimum config for vim
set nocompatible       " Be iMproved
let g:vim_bootstrap_langs = 'go,html,javascript,typescript,python,c,c++'

let g:vim_bootstrap_editor = 'vim'
let g:vi_home = expand('~/.vim')
let g:vi_data = expand('~/.local/share/vim')
let vim_plug_exists = g:vi_home . '/autoload/plug.vim'

" *****************************************************************************
" Vim-PLug core
" ****************************************************************************
let g:vimplug_ready = 'yes'
if !filereadable(vim_plug_exists)
  if !executable('curl')
    echoerr 'You should have curl before installing vim-plug automatically! Or install vim-plug manually.'
    execute 'q!'
  endif

  echo "Installing Vim-Plug...\n"

  " echo vim_plug_exists
  let curl_cmd = "!\curl " . "-fLo " . vim_plug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  execute curl_cmd
  let g:vimplug_ready = 'no'

  autocmd VimEnter * PlugInstall
endif

" Enable matchit plugin shipped with vim
" runtime macros/matchit.vim
packadd! matchit

" call plug#begin(g:vi_home . '/plugged')
call plug#begin(g:vi_data . '/plugged')
  " maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs.
  Plug 'editorconfig/editorconfig-vim'
  " Vim colorscheme
  Plug 'altercation/vim-colors-solarized'

  " Status/tabline for vim
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Plug 'itchyny/lightline.vim'
  " Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'airblade/vim-gitgutter'

  " Fuzzy file, buffer, mru, tag, etc finder.
  " Fuzzy Finding: CtrlP –> fzf, because it's asynchronous and fast
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf', { 'do': { -> fzf#install() } }
  elseif isdirectory('/home/linuxbrew/.linuxbrew/opt/fzf')
    Plug '/home/linuxbrew/.linuxbrew/opt/fzf', { 'do': { -> fzf#install() } }
  else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  endif
  Plug 'junegunn/fzf.vim'

  " Git wrapper
  Plug 'tpope/vim-fugitive'

  " toggling bookmarks per line.
  Plug 'MattesGroeger/vim-bookmarks'
  " Eclipse like task list
  Plug 'vim-scripts/TaskList.vim'

  " Universal CTags: tagging engine that scans project files and generates tag files.
  " Autotag: automatically update the tag files after each save.
  " Tagbar: displays a window with a hierarchical list of tags in the current file.
  Plug 'majutsushi/tagbar'

  Plug 'voldikss/vim-floaterm'

  " ****** Coding/Programming(code, build and test) ***********************************
  Plug 'easymotion/vim-easymotion'

  " Repeat.vim remaps . in a way that plugins can tap into it.
  Plug 'tpope/vim-repeat'
  " Comment stuff out, Use gcc to comment out a line
  " gc in visual mode and operator pending mode (like gc[motion], gcap)
  Plug 'tpope/vim-commentary'
  " provides insert mode auto-completion for quotes, parens, brackets, etc.
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'

  " A Narrow Region Plugin for vim, focus on a selected region while making the rest inaccessible.
  Plug 'chrisbra/NrrwRgn'

  " ALE providing linting (syntax checking and semantic errors)
  Plug 'w0rp/ale'

  " a suite consist of supertab, YouCompleteMe and ultisnips
  Plug 'ervandew/supertab'
  " Build YouCompleteMe, info = {name, status - ['installed', 'updated', 'unchanged'], force - set by PlugInstall or PlugUpdate}
  function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      " !python3 ./install.py --clangd-completer --go-completer --ts-completer --rust-completer --java-completer(JDK8 required )
      !python3 ./install.py --clangd-completer --go-completer --ts-completer
    endif
  endfunction
  " Todo: install(update and build automaticlly) YouCompleteMe (A code-completion engine for Vim)
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }


  " The ultimate snippet solution for Vim
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'


  " ****** Custom Language bundles ****************************************************
  " ------------Golang Bundle ----------------------------------
  " Plug 'sebdah/vim-delve', {'for': 'go'}
  Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for':'go'}

  "" ------------Html/css/Javascript Bundle ----------------------------------
  Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript','typescript']}
  Plug 'AndrewRadev/tagalong.vim', {'for': ['html', 'jsx', 'javascript','typescript', 'xml']}

  "" Include user's extra bundle
  " Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
call plug#end()

" General Settings
" source $HOME/.config/nvim/vim-plug/plugins.vim
" source $HOME/.config/nvim/general/settings.vim
" source $HOME/.config/nvim/general/abbreviations.vim
" source $HOME/.config/nvim/keys/mappings.vim

" " Plugin Configuration
" source $HOME/.config/nvim/keys/which-key.vim
" source $HOME/.config/nvim/plug-config/fzf.vim
" ...
execute 'source ' . g:vi_home . '/general.vim'
if g:vimplug_ready == 'yes'
  execute 'source ' . g:vi_home . '/plugin_common.vim'
  execute 'source ' . g:vi_home . '/plugin_vim.vim'
  execute 'source ' . g:vi_home . '/tagbar.vim'
endif

"*****************************************************************************
"" Include user's local vim config
if filereadable(g:vi_home . '/local.vim')
  execute 'source ' . g:vi_home . '/local.vim'
endif