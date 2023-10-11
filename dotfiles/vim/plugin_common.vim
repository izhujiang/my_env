"------------------------------------------------------------------------------
" UI
"------------------------------------------------------------------------------
" solarized
if isdirectory(g:vi_data . "/plugged/vim-colors-solarized")
  let g:solarized_termcolors=256
  " set background=dark
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif
  colorscheme solarized
else
  colorscheme zellner
endif

"------------------------------------------------------------------------------
" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
if !exists('g:airline_powerline_fonts')
  let g:airline_powerline_fonts = 1
  " let g:airline_theme='material'
  " let g:airline_theme='tomorrow'
  let g:airline_theme = 'powerlineish'
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

  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tagbar#enabled = 1

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline#extensions#virtualenv#enabled = 1
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" -----------------------------------------------------------------------------
"  vim-gitgutter
"  disable vim-gitgutter  mappings, <leader>hs/hu/hp affect window movement <leader>h
let g:gitgutter_map_keys = 0

nnoremap ]h <Plug>(GitGutterNextHunk)
nnoremap [h <Plug>(GitGutterPrevHunk)

"------------------------------------------------------------------------------
" Explorer, like IDE
" ------------------------------------------------------------------------------
let g:netrw_liststyle = 3

" ------------------------------------------------------------------------------
" Tagbar
let g:tagbar_autofocus = 1

nnoremap <silent> <leader>tt :TagbarToggle<CR>
" generate tags file (index of source code)
nnoremap <leader>tg :!ctags -R --exclude=.git<CR>


" ------------------------------------------------------------------------------
"" fzf.vim 
if executable('fd')
  let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
endif

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git'
endif

" ripgrep
if executable('rg')
  set grepprg=rg\ --column\ --line-number\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Print each file that would be searched without actually performing the search. used by :Files
  let $FZF_DEFAULT_COMMAND = "rg --files --hidden --follow -g '!.git*/'"
endif

" This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.6 } }
endif

" Default option for fzf_preview_window
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --exclude=.git'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" find filename under current directory and open it/them.
nnoremap <silent> <leader>ff :Files!<CR>
nnoremap <silent> <leader>fw :FZF -m ~/workspace<CR>
nnoremap <silent> <leader>fb :Buffers!<CR>
nnoremap <silent> <leader>fh :History!<CR>
" find window by fuzzy name and activate it
nnoremap <silent> <leader>fw :Windows!<CR>
" git ls-files
nnoremap <silent> <leader>fg :GFiles?<CR>

" find text/pattern in contents of files under current directory, open the file and jump into target.
nnoremap <silent> <leader>fr :Rg<CR>
" Lines in loaded buffers
nnoremap <silent> <leader>fl :Lines<CR>
" Tags in the project (ctags -R)
nnoremap <silent> <leader>ft :Tags<CR>

" find keyword in 'search forward history' and do search again
nnoremap <silent> <leader>f/ :History/<CR>
" find keyword in ': history' and execute it.
nnoremap <silent> <leader>f: :History:<CR>
" find vim's built-in and third-party Commands and put it in :prompt
nnoremap <silent> <leader>fc :Commands<CR>

" help(ayuda), find help topic and jump to it
" nnoremap <silent> <leader>fa :Helptags<CR>
" find filetype and apply it (likes, set filetype=vim).
" nnoremap <silent> <leader>fi :Filetypes<CR>
" find snippet and inert it into current buffer
" nnoremap <silent> <leader>fs :Snippets<CR>
" nnoremap <silent> <leader>fm :Marks<CR>


" acts like ctrlp
nnoremap <leader>fz :call ContextualFZF()<CR>
function! ContextualFZF()
    " Determine if inside a git repo
    silent exec "!git rev-parse --show-toplevel"
    redraw!

    if v:shell_error
        " Search in current directory
        call fzf#run({
          \'sink': 'e',
          \'down': '60%',
        \})
    else
        " Search in entire git repo
        call fzf#run({
          \'sink': 'e',
          \'down': '60%',
          \'source': 'git ls-tree --full-tree --name-only -r HEAD',
        \})
    endif
endfunction

" TODO: user-defined commands
command! -bang Colors
  \ call fzf#vim#colors({'options': '--reverse'}, <bang>0)

"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --color=always --follow 
  \ --glob "!.git/*" '.shellescape(<q-args>).'| tr -d "\017"', 1,
  \ <bang>0)

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping selecting mappings, <leader><tab> invoke :Maps to find and execute command
nnoremap <leader><tab> <plug>(fzf-maps-n)
xnoremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
inoremap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <c-x><c-l> <plug>(fzf-complete-line)

" Replace the built-in dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete#word()
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word('cat /usr/share/dict/words')
inoremap <expr> <c-x><c-l> fzf#vim#complete#line()
if executable('fd')
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
endif
if executable('rg')
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
endif
" insert sentence by join fzf multi-words
function! s:make_sentence(lines)
  return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
endfunction
inoremap <expr> <c-x><c-s> fzf#complete({
  \ 'source':  'cat /usr/share/dict/words',
  \ 'reducer': function('<sid>make_sentence'),
  \ 'options': '--multi --reverse --margin 15%,0'})

augroup event_completion_preview_close
  autocmd!
  function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction
  autocmd! User FzfStatusLine call <SID>fzf_statusline()
augroup END


"------------------------------------------------------------------------------
" vim-floaterm
" https://github.com/voldikss/vim-floaterm
let g:floaterm_width = 0.9
let g:floaterm_height = 0.7
let g:floaterm_opener = 'edit'
let g:floaterm_autoclose = 2

" use console(C) for terminal
let g:floaterm_keymap_toggle = '<leader>C'
let g:floaterm_keymap_new    = '<leader>te'
let g:floaterm_keymap_kill   = '<leader>tq'
let g:floaterm_keymap_next   = '<leader>tn'
let g:floaterm_keymap_prev   = '<leader>tp'

" ft/floaterm somefile.txt, open files from within :terminal without starting a nested nvim
" Execute git commit in the terminal window without starting a nested vim/nvim.
" :FloatermNew fzf
" :FloatermNew rg

"------------------------------------------------------------------------------
" vim-fugitive
if exists("*fugitive#statusline")
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif
" Ex commands with arguments is more intuitive than shortcuts in normal mode
noremap <Leader>gg :Git<CR>
noremap <Leader>gs :Git switch
noremap <Leader>gw :Gwrite<CR>
noremap <Leader>gr :Gread<CR>
noremap <Leader>ga :Git add
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gm :Git merge
noremap <Leader>gb :Git rebase -i<CR>
noremap <Leader>gl :GcLog<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gx :GDelete<CR>
noremap <Leader>gp :Ggrep
"
" close automatically the buffer created by openning git object using fugitive.
autocmd BufReadPost fugitive://* set bufhidden=delete

"------------------------------------------------------------------------------
" Coding features
"------------------------------------------------------------------------------
" EditorConfig plugin for Vim http://editorconfig.org
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"------------------------------------------------------------------------------
" easymotion
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
"
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
" makes EasyMotion work similarly to Vim's smartcase option for global searches.
let g:EasyMotion_smartcase = 1

" Type Enter or Space key and jump to first match
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" let g:EasyMotion_prompt = '{n}>>> '
let g:EasyMotion_prompt = 'EasyMotion search for {n} character(s): '

" let g:EasyMotion_inc_highlight = 1
" let g:EasyMotion_move_highlight = 1
" let g:EasyMotion_landing_highlight = 0
"
" let g:EasyMotion_add_search_history = 1
" let g:EasyMotion_off_screen_search = 1
"
" let g:EasyMotion_verbose = 1

" Set this keymapping to the key sequence to use as the prefix of the mappings
" map \ <Plug>(easymotion-prefix)
"
" The default configuration defines the following mappings in normal, visual
" and operator-pending mode if |g:EasyMotion_do_mapping| is on:
"     Default Mapping      | Details
"     ---------------------|----------------------------------------------
"     <Leader>f{char}      | Find {char} to the right. See |f|.
"     <Leader>F{char}      | Find {char} to the left. See |F|.
"     <Leader>t{char}      | Till before the {char} to the right. See |t|.
"     <Leader>T{char}      | Till after the {char} to the left. See |T|.
"     <Leader>w            | Beginning of word forward. See |w|.
"     <Leader>W            | Beginning of WORD forward. See |W|.
"     <Leader>b            | Beginning of word backward. See |b|.
"     <Leader>B            | Beginning of WORD backward. See |B|.
"     <Leader>e            | End of word forward. See |e|.
"     <Leader>E            | End of WORD forward. See |E|.
"     <Leader>ge           | End of word backward. See |ge|.
"     <Leader>gE           | End of WORD backward. See |gE|.
"     <Leader>j            | Line downward. See |j|.
"     <Leader>k            | Line upward. See |k|.
"     <Leader>n            | Jump to latest '/' or '?' forward. See |n|.
"     <Leader>N            | Jump to latest '/' or '?' backward. See |N|.
"     <Leader>s            | Find(Search) {char} forward and backward.
"                          | See |f| and |F|.

" TODO: need to avaid confix with other plugins
nnoremap  <Leader><Leader>f <Plug>(easymotion-bd-f)
nnoremap <Leader><Leader>F <Plug>(easymotion-overwin-f)
" " s{char}{char} to move to {char}{char}
nnoremap  <Leader><Leader>s <Plug>(easymotion-s2)
nnoremap <Leader><Leader>S <Plug>(easymotion-overwin-f2)

nnoremap <Leader><Leader>t <Plug>(easymotion-t2)

" " Move to line
noremap <Leader><Leader>l <Plug>(easymotion-bd-jk)
nnoremap <Leader><Leader>l <Plug>(easymotion-overwin-line)

" " Move to word
noremap  <Leader><Leader>w <Plug>(easymotion-bd-w)
nnoremap <Leader><Leader>w <Plug>(easymotion-overwin-w)

noremap  <Leader><Leader>/ <Plug>(easymotion-sn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
noremap  <Leader><Leader>n <Plug>(easymotion-next)
noremap  <Leader><Leader>N <Plug>(easymotion-prev)

" jumpto anywhere (Beginning and End of word, Camelcase, after '_', and after '#'.)
" in the {left, right, up, down} direction
noremap <Leader><Leader>l <Plug>(easymotion-lineforward)
noremap <Leader><Leader>j <Plug>(easymotion-j)
noremap <Leader><Leader>k <Plug>(easymotion-k)
noremap <Leader><Leader>h <Plug>(easymotion-linebackward)

" useful for operater command: cz, yz, dz and vz
onoremap z <Plug>(easymotion-s2)
onoremap <Leader><Leader>/ <Plug>(easymotion-tn)
"------------------------------------------------------------------------------
" UltiSnips
" YouCompleteMe and UltiSnips compatibility.
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Additional UltiSnips config.
" let g:UltiSnipsSnippetsDir = '/.vim/ultisnips'
" let g:UltiSnipsSnippetDirectories = [
"       \ $HOME . '/.vim/ultisnips',
"       \ $HOME . '/.vim/ultisnips-private'
"       \ ]

"------------------------------------------------------------------------------
" ALE, for syntax lint
" Asynchronous Lint Engine, ALE makes use of NeoVim and Vim 8 job control functions and timers to run linters on the

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" disable running the linters automatically
" let ale lint and fix run automatically when working on server, workstation or my powerful MBP
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
" Import: ALE is primarily focused on integrating with external programs through virtually any means,
" disable all LSP features in ALE, LSP features already provided by YouCompleteMe or coc.nvim, such as auto-completion.
" ALE lint/diagnostic and fix run through the whole buffer, YouCompleteMe focus on instant diagnostics.
" g:ale_disable_lsp = 1 cause ALE to ignore all lsp linters (tsserver...) for any language

" Disable ALE's LSP functionality entirely when running ALE in combination with another LSP client, 
" When this option is set to `1`, ALE ignores all linters powered by LSP, and `tsserver` as well.
let g:ale_disable_lsp = 0

let g:ale_use_neovim_diagnostics_api = 0
" If enabled, this option will disable ALE's standard UI, and instead send
" all linter output to Neovim's diagnostics API. This allows you to collect
" errors from nvim-lsp, ALE, and anything else that uses diagnostics all in
" one place. The following options are ignored when using the diagnostics API:
"		- |g:ale_set_highlights|
"		- |g:ale_set_signs|
"		- |g:ale_virtualtext_cursor|

" let g:ale_virtualtext_cursor = 'disabled'
let g:ale_virtualtext_cursor = 'current'
" let g:ale_virtualtext_cursor = 'all'


let g:ale_completion_enabled = 0
let g:ale_completion_tsserver_autoimport = 0

" use the quickfix list instead of the loclist
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
" show Vim windows for the loclist or quickfix items when a file contains warnings or errors
let g:ale_open_list = 1
" close the window when errors disappear.
let g:ale_keep_list_window_open = 0

" By default, all available tools for all supported languages will be run.
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
" TODO: set typescript linter as deno lsp, otherwise tsserver for normal typescript project
      " \ 'typescript': ['tsserver', 'eslint'],
      " DO NOT use golangci-lint, which can't highlight the errors when linters return non-zero exit code.
      " Use golangci-lint in automatic CI/CD process.
      " \ 'go': [ 'golangci-lint'], 

let g:ale_linters = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'sh': ['shellcheck'],
      \ 'javascript': ['deno', 'eslint'],
      \ 'typescript': ['deno', 'eslint'],
      \ 'python': ['flake8', 'pylint'],
      \ 'rust': ['cargo'],
      \ 'c': ['clangd'],
      \ 'cpp': ['clangd'],
      \ 'go': [ 'gopls'],
      \ 'vim': ['ale_custom_linting_rules', 'vint'],
      \ 'dockerfile': ['dockerfile_lint', 'hadolint'],
      \ 'html': ['htmlhint'],
      \ 'css': ['stylelint']
      \ }
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
      \ 'go': ['goimports', 'gopls'],
      \ 'markdown': ['remove_trailing_lines'],
      \ 'vim': ['remove_trailing_lines'],
      \ }

let g:ale_go_langserver_executable = 'gopls'

" Ref: golangci-lint run --help, with --fix will modify files with external linter asynchronously.
" Better to use {CurrentPreject}/.golangci.yml or ${HOME}/.golangci.yml configuration file
let g:ale_go_golangci_lint_options = '' " Or using command_line arguments
" let g:ale_go_golangci_lint_options = '--enable-all -D forbidigo -D maligned -D golint -D scopelint 
" \ -D interfacer -D testpackage -D paralleltest --fix'
let g:ale_go_golangci_lint_package = 1
" let g:ale_python_pylint_options = '--load-plugins pylint_django'

let g:ale_sign_error = '*>'
let g:ale_sign_warning = '>>'
" let g:ale_sign_column_always = 1

" Show n lines of errors (default: 10)
" let g:ale_list_window_size = 10

"
" let g:ale_set_highlights = 0
" highlight ALEWarning ctermbg=DarkMagenta

let g:airline#extensions#ale#enabled = 1
function! LinterStatus() abort
  if exists('*ale#statusline#Count')
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
  endif

endfunction

set statusline=%{LinterStatus()}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


augroup event_ale
  autocmd!
  autocmd User ALELintPre    call <SID>ClearQuickfixList()
  autocmd User ALELintPost   call <SID>RefreshBuffersAfterLint()
augroup END

" Check if any buffers were changed outside of Vim (linters (goimports, gofumpt ... ) fix file asynchronously)
function! s:RefreshBuffersAfterLint()
  checktime
endfunction
function! s:ClearQuickfixList()
  call setqflist([])
endfunction

" -----------------------------------------------------------------------------
" Golong, vim-go
augroup event_golang
  autocmd!
  let g:go_version_warning = 0

  let g:go_code_completion_enabled = 0

  let g:go_test_show_name = 1
  " let g:go_test_timeout= '10s'

  let g:go_play_open_browser = 0
  " let g:go_play_browser_command = ''
  " let g:go_play_browser_command = 'chrome'
  " let g:go_play_browser_command = 'firefox-developer %URL% &'

  let g:go_auto_type_info = 0
  " let g:go_info_mode = 'gopls'

  " let g:go_auto_sameids = 0

  " let g:go_updatetime = 800
  " let g:go_jump_to_error = 1

  let g:go_fmt_autosave = 0
  " let g:go_fmt_command = 'gopls'
  let g:go_fmt_command = 'goimports'
  " let g:go_fmt_options = {
  "   \ 'gofmt': '-s',
  "   \ 'goimports': '-local mycompany.com',
  "   \ }
  "
  " let g:go_fmt_fail_silently = 0

  let g:go_imports_autosave = 0
  " let g:go_imports_mode = 'gopls'

  " let g:go_mod_fmt_autosave = 1

  " run `godoc` on words under the cursor with |K|, which override the 'keywordprg' setting 
  " let g:go_doc_keywordprg_enabled = 1
  let g:go_doc_max_height = 25
  " let g:go_doc_url = 'https://pkg.go.dev'
  " let g:go_doc_popup_window = 0
  " let g:go_doc_balloon = 0


  let g:go_def_mode = 'gopls'
  let g:go_fillstruct_mode = 'gopls'
  let g:go_referrers_mode = 'gopls'
  let g:go_implements_mode = 'gopls'

  " Use this option to enable/disable 
  " the default mapping of CTRL-], <C-LeftMouse>, g<C-LeftMouse> and (`gd`) for GoDef, 
  " CTRL-t for :GoDefPop, and (`gD`) for :GoDefType.
  let g:go_def_mapping_enabled = 1

  let g:go_def_reuse_buffer = 1

  " let g:go_bin_path = ''
  let g:go_search_bin_path_first = 1


  " let g:go_snippet_engine = 'automatic'

  " let g:go_get_update = 1

  " let g:go_guru_scope = []

  " let g:go_build_tags = ''

  " let g:go_textobj_enabled = 1
  " let g:go_textobj_include_function_doc = 1
  " let g:go_textobj_include_variable = 1

  let g:go_metalinter_autosave = 0
  " let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  " let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  let g:go_metalinter_command = 'golangci-lint'
  " let g:go_metalinter_deadline = '5s'


  let g:go_list_type = "quickfix"
  let g:go_list_height = 10
  " let g:go_list_type_commands = {}
  " let g:go_list_type_commands = {"GoBuild": "locationlist"}
  " let g:go_list_autoclose = 1

  " let g:go_asmfmt_autosave = 0

  let g:go_term_enabled = 1
  let g:go_term_mode = 'split'
  let g:go_term_reuse = 1
  let g:go_term_width = 30
  let g:go_term_height = 10
  let g:go_term_close_on_exit = 0

  let g:go_alternate_mode = 'edit'

  let g:go_rename_command = 'gopls'
  let g:go_gorename_prefill = 'expand("<cword>") =~# "^[A-Z]"' .
        \ '? go#util#pascalcase(expand("<cword>"))' .
        \ ': go#util#camelcase(expand("<cword>"))'


  let g:go_gopls_enabled = 1
  "
  " TODO: wait for a solution for sharing gopls instance between vim-go, YouCompleteMe, Ale and other plugins.
  " The commandline arguments to pass to gopls. By default, `['-remote=auto']`.
  " let g:go_gopls_options = ['-remote=auto']
  " let g:go_gopls_options = []

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
  let g:go_diagnostics_level = 0

  " let g:go_template_autocreate = 1
  " let g:go_template_file = 'hello_world.go'
  " let g:go_template_test_file = 'hello_world_test.go'
  let g:go_template_use_pkg = 1

  let g:go_decls_includes = 'func,type'
  let g:go_decls_mode = 'fzf'

  let g:go_echo_command_info = 1
  let g:go_echo_go_info = 0
  let g:go_statusline_duration = 60000

  let g:go_addtags_transform = 'snakecase'
  " let g:go_addtags_skip_unexported = 0

  " let g:go_debug = []

  let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
  let g:go_highlight_types = 1
  let g:go_highlight_functions = 1
  " let g:go_highlight_function_parameters = 0
  " let g:go_highlight_function_calls = 0
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1
  let g:go_highlight_space_tab_error = 0
  " let g:go_highlight_chan_whitespace_error = 0
  " let g:go_highlight_array_whitespace_error = 0
  " let g:go_highlight_trailing_whitespace_error = 0
  " let g:go_highlight_format_strings = 1
  " let g:go_highlight_variable_declarations = 0
  " let g:go_highlight_variable_assignments = 0
  let g:go_highlight_string_spellcheck = 0
  " let g:go_highlight_diagnostic_errors = 1
  " let g:go_highlight_diagnostic_warnings = 1


  " debugger options
  let g:go_debug_windows = {
        \ 'vars':       'leftabove 50vnew',
        \ 'stack':      '20split new',
        \ 'goroutines': '10split new',
        \ 'out':        'wincmd l | 5split new +set nonumber',
  \ }
  let g:go_debug_preserve_layout = 1
  " let g:go_debug_address = '127.0.0.1:8181'
  " An empty string (`''`) will suppress logging entirely.  Default: `'debugger,rpc'`:
  let g:go_debug_log_output = ''
  let g:go_highlight_debug = 1
  let g:go_debug_breakpoint_sign_text = '>'


  autocmd FileType go nnoremap <leader>b  :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nnoremap <leader>B  :make<CR>
  autocmd FileType go nnoremap <leader>r  <Plug>(go-run)
  autocmd FileType go nnoremap <leader>t <Plug>(go-test)
  autocmd FileType go nnoremap <leader>T <Plug>(go-test-func)
  autocmd FileType go nnoremap <leader>C <Plug>(go-coverage-toggle)

  autocmd FileType go nnoremap <leader>a <Plug>(go-alternate-edit)
  " autocmd FileType go nnoremap <leader>a <Plug>(go-alternate-vertical)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  autocmd FileType go nnoremap gd <Plug>(go-def)
  " autocmd FileType go nnoremap gd <Plug>(go-def-vertical)
  autocmd FileType go nnoremap gp <Plug>(go-def-pop)

  " ]] -> jump to next function
  " [[ -> jump to previous function

  " enable 'K' invokes :GoDoc instead of man (g:go_doc_keywordprg_enabled = 1)
  autocmd FileType go nnoremap K <Plug>(go-doc)
  " autocmd FileType go nnoremap <leader>i <Plug>(go-info)
  " autocmd FileType go nnoremap <leader>I <Plug>(go-describe)

  " autocmd FileType go nnoremap <leader>cp <Plug>(go-channelpeers)

  " Only :GoDebugAttach, :GoDebugStart, :GoDebugTest, and :GoDebugBreakpoint are available by default.
  " The rest of the commands and mappings become available after executing :GoDebugContinue.
  autocmd FileType go nnoremap <leader>d :GoDebugStart<cr>
  autocmd FileType go nnoremap <leader>dt :GoDebugTest<cr>
  " autocmd FileType go nnoremap <leader>da :GoDebugAttach 
  autocmd FileType go nnoremap <leader>db :GoDebugBreakpoint<cr>

  " TODO: define keymaps when enter debug mode
  autocmd FileType go nnoremap <C-s> <Plug>(go-debug-stepout)
  autocmd FileType go nnoremap <C-t> <Plug>(go-debug-stop)

  " Contains custom key mapping information to customize the active mappings when debugging.
  " Todo: keys only valid for the active mapping, to be updated.
  " (the default mappingsm https://github.com/fatih/vim-go/issues/3012)
  let g:go_debug_mappings = {
    \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
    \ '(go-debug-print)':{'key': 'p', 'arguments': '<nowait>'},
    \ '(go-debug-breakpoint)': {'key': 'b','arguments': '<nowait>'},
    \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
    \ '(go-debug-step)': {'key': 's', 'arguments': '<nowait>'},
    \ '(go-debug-halt)': {'key': '<SPACE>'},
  \}
  " TODO: Valid keys defined by configureMappings function in plugged/vim-go/autoload/go/debug.vim:
  " '(go-debug-breakpoint)',
  " '(go-debug-continue)',
  " '(go-debug-halt)',
  " '(go-debug-next)',
  " '(go-debug-print)',
  " '(go-debug-step)'
    " \ '(go-debug-stepout)': {'key': 's', 'arguments': '<nowait>'},
    " \ '(go-debug-stop)': {'key': 'T','arguments': '<nowait>'},
  " memo: put cursor on variable and press 'p' to print out the value

  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      " :GoBuild, jomp to the first error.
      call go#cmd#Build(0)
      " :GoBuild!, cursor stays
      " call go#cmd#Build(1)
    endif
  endfunction
augroup END

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

" autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
" nnoremap <silent> <leader> :<c-u>WhichKey  ','<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey '<Space>'<CR>