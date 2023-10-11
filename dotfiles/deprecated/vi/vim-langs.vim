" ----make/cmake
augroup vi-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" ----Golong, vim-go settings
augroup vi-go
    autocmd!

    autocmd FileType go nmap <leader>b  :<C-u>call <SID>build_go_files()<CR>
    " autocmd FileType go nmap <leader>gb  :<C-u>call <SID>build_go_files()<CR>
    " autocmd FileType go nmap <leader>gb  <Plug>(go-build)
    "
    " autocmd FileType go nmap <leader>r  <Plug>(go-run-split) <esc>
    " don't use <Plug> go-run command, it is better to run with go run in term which will close by clicking anyke which will close by clicking any key
    " execute the whole project
    " autocmd Filetype go nmap <silent><Leader>r :w<cr>:split term://go run *.go<CR>
    " execute current file
    autocmd Filetype go nmap <silent><Leader>r :w<cr>:split term://go run %<CR>
    " execute the whole project
    " autocmd Filetype go nmap <silent><Leader>r :vsplit term://go run *.go<CR>
    " autocmd FileType go nmap <leader>gr  <Plug>(go-run)


    autocmd FileType go nmap <leader>t <Plug>(go-test)
    " autocmd FileType go nmap <leader>gt <Plug>(go-test)
    autocmd FileType go nmap <leader>tf <Plug>(go-test-func)
    " compile test code files but doesn't run test code,
    " which is done by build_go_files when current file is _test.go.
    " autocmd FileType go nmap <leader>gtc <Plug>(go-test-compile)

    " go-coverage-toggle, Calls go test -coverprofile-temp.out for the current package and shows the coverage annotation.
    " If run again it acts as a toggle and clears the annotation.
    " autocmd FileType go nmap <leader>gc <Plug>(go-coverage)
    autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
    " autocmd FileType go nmap <leader>gc <Plug>(go-coverage-clear)
    " autocmd FileType go nmap <leader>gcb :GoCoverageBrowser<cr>

    autocmd FileType go nmap <leader>m :GoMetaLinter<cr>

    autocmd FileType go nmap <leader>a :GoAlternate<cr>
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go nmap <leader>av :AV<cr>
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go nmap <leader>as :AS<cr>
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

    autocmd FileType go nmap <leader>im <Plug>(go-implements)
    " autocmd FileType go nmap <leader>gi <Plug>(go-info)
    autocmd FileType go nmap <leader>i <Plug>(go-info)
    " vim-go overrides the default normal shortcut K so that it invokes :GoDoc instead of man
    autocmd FileType go nmap <leader>d <Plug>(go-doc)
    autocmd FileType go nmap <leader>dv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>s  :GoSameIdsToggle<cr>

    " vim builtin gd shortcut for go_def?
    " autocmd FileType go nmap <leader>gds <Plug>(go-def-split)
    " autocmd FileType go nmap <leader>gdv <Plug>(go-def-vertical)
    " autocmd FileType go nmap <leader>gdt <Plug>(go-def-tab)

    autocmd FileType go nmap <leader>dc :GoDecls<cr>
    autocmd FileType go nmap <leader>dcd :GoDeclsDir<cr>

    autocmd FileType go nmap <leader>n <Plug>(go-rename)

    " Currently by default :GoDecls and :GoDeclsDir show type and function declarations.
    let g:go_decls_includes = "func,type"

    " The 'go to definition' command families are very powerful but yet easy to use.
    " Under the hood it uses by default the tool guru.guru has an excellent track record of being very predictable.
    " But sometimes it's very slow for certain queries.
    " vim-go was using godef which is very fast on resolving queries.
    let g:go_def_mode = 'guru'
    " let g:go_def_mode = 'godef'

    " vim-go has a couple of commands to make it easy to manipulate the import declarations.
    " :GoImport, :GoImportAs, :GoDrop,
    " format the file automatically when saved.
    let g:go_fmt_autosave = 1
    " let g:go_fmt_command = "gofmt" "Explicited the formater plugin (gofmt, goimports, goreturn...)
    " whenever save file, goimports will automatically format as well as rewrite import declarations.
    " goimports is a replacement for gofmt
    let g:go_fmt_command = "goimports"

    " stop fmt show errors in quickfix list
    " let g:go_fmt_fail_silently = 1

    "  expanded to valid field tag, default vim-go uses snake_case transform
    let g:go_addtags_transform = "snake_case"
    " let g:go_addtags_transform = "camelcase"
    "
    " By default syntax-highlighting for Functions, Methods and Structs is disabled.
    " Let's enable them!
    let g:go_highlight_types = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_space_tab_error = 0
    let g:go_highlight_array_whitespace_error = 0
    let g:go_highlight_trailing_whitespace_error = 0
    let g:go_highlight_extra_types = 1


    " vim-go to support text object motion features like this, vif, vaf, daf, vaf, caf, cif(command in/all function)
    let g:go_textobj_include_function_doc = 1

    "
    " There are two types of error lists in Vim: location list and quickfix
    " use only quickfix for Build, Check, Tests, et
    let g:go_list_type = "quickfix"

    " :GoTest times out after 10 seconds by default.
    let g:go_test_timeout = '10s'

    " :GoMetaLinter for a given Go source code. By default it'll run go vet, golint and errcheck concurrently.
    " gometalinter collects all the outputs and normalizes it to a common format.
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_autosave = 1
    let g:go_metalinter_autosave_enabled = ['golint']
    let g:go_metalinter_deadline = "5s"

    " :GoInfo, Identifier resolution
    " vim-go has a support to automatically show the information whenever you move your cursor.
    " let g:go_auto_type_info = 1
    let g:go_auto_type_info = 0
    " status line is updated automatically
    " set updatetime=800

    " :GoSameIds :GoSameIdsClear,and GoSameIdsToggle
    " go_auto_sameids enabled by :GoSameIDsAutoToggle
    let g:go_auto_sameids = 0


    " share code (:GoPlay)
    " let g:go_play_open_browser = 0
    " let g:go_play_browser_command = "chrome"

    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
augroup END

"By default  syntax highlighting for Go HTML template is enabled for .tmpl files.
" au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

" mapping to <leader>gb
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


" ---- java
augroup vi-java
    autocmd!
    autocmd BufNewFile,BufRead *.gradle setf groovy
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType java,groovy :execute "compiler gradle"
augroup END

augroup vi-javascript
    autocmd!
    au BufNewFile,BufRead *.handlebars set filetype=html
augroup END

" ---- Markdown
" options ref to https://github.com/plasticboy/vim-markdown
" autocmd BufNewFile,BufReadPost *.md
" \ set filetype=markdown
" let g:vim_markdown_folding_disabled = 1
" \ let g:vim_markdown_folding_style_pythonic = 1
" \ let g:vim_markdown_override_foldtext = 0
" \ let g:vim_markdown_folding_level = 6
" let g:vim_markdown_no_default_key_mappings = 1
" \ let g:vim_markdown_toc_autofit = 1
" let g:vim_markdown_emphasis_multiline = 0
" \ let g:vim_markdown_math = 1
" \ set conceallevel=2
" let g:vim_markdown_conceal = 0
" let g:tex_conceal = ""
