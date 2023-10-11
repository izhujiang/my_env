" Enable warning when using an unsupported version of Vim. By default it is enabled.
  let g:go_version_warning = 1

" Enable code completion with 'omnifunc'. By default it is enabled.
  let g:go_code_completion_enabled = 1

" Show the name of each failed test before the errors and logs output by the test. By default it is disabled.
  let g:go_test_show_name = 0

" Use this option to change the test timeout of |:GoTest|. By default it is set to 10 seconds . >
  let g:go_test_timeout= '10s'

" Use this option to open browser after posting the snippet to play.golang.org with |:GoPlay|. By default it's enabled. >
  let g:go_play_open_browser = 1
" Browser to use for |:GoPlay|, |:GoDocBrowser|, and |:GoLSPDebugBrowser|. The url must be added with `%URL%`, and it's advisable to include `&` to make sure the shell returns.
  " let g:go_play_browser_command = 'firefox-developer %URL% &'
" By default it tries to find it automatically for the current OS. >
  let g:go_play_browser_command = ''

Use this option to show the type info (|:GoInfo|) for the word under the cursor automatically. By default it's disabled.
  let g:go_auto_type_info = 0
" Use this option to define the command to be used for |:GoInfo|. By default `gopls` is used, because it is the fastest and is known to be highly accurate.
" One might also use `guru` for its accuracy.  Valid options are `gopls` and `guru`.
  let g:go_info_mode = 'gopls'

" Use this option to highlight all uses of the identifier under the cursor (|:GoSameIds|) automatically. By default it's disabled.
  let g:go_auto_sameids = 0

" Use this option to configure the delay until it starts some jobs (see |'g:go_auto_type_info'|, |'g:go_auto_sameids'|). If set to 0, it uses the value from 'updatetime'. By default it's set to 800ms.
  let g:go_updatetime = 800

" Use this option to enable/disable passing the bang attribute to the mappings (e.g. |(go-build)|, |(go-run)|, etc.) and the metalinter on save.  This setting is only useful for changing the behaviour of our custom static mappings. By default it's enabled.
  let g:go_jump_to_error = 1

" Use this option to auto |:GoFmt| on save.  By default it's enabled.
  let g:go_fmt_autosave = 0
" Use this option to define which tool is used to format code. Valid options are `gofmt`, `goimports`, and `gopls`. By default `gofmt` is used.
  let g:go_fmt_command = "gopls"
" Use this option to add additional options to the |'g:go_fmt_command'|. It's value type can be either a string or a dictionary. Default is empty.
  let g:go_fmt_options = {}
  " let g:go_fmt_options = {
  "   \ 'gofmt': '-s',
  "   \ 'goimports': '-local mycompany.com',
  "   \ }
  "
" go_fmt_options' at a buffer-level setting.
  " autocmd FileType go let b:go_fmt_options = {
  "   \ 'goimports': '-local ' .
  "     \ trim(system('{cd '. shellescape(expand('%:h')) .' && go list -m;}')),
  "   \ }


" Use this option to disable showing a location list when |'g:go_fmt_command'| fails. By default the location list is shown.
  let g:go_fmt_fail_silently = 0

" Use this option to enable fmt's experimental mode. By default it's disabled.
  let g:go_fmt_experimental = 0


" Use this option to auto |:GoImports| on save.  By default it's disabled.
  let g:go_imports_autosave = 0
" Use this option to define which tool is used to adjust imports. Valid options are `goimports` and `gopls`. The buffer will not be formatted when this is set to `gopls`. By default `goimports` is used.
  let g:go_imports_mode = "gopls"

" Use this option to auto |:GoModFmt| on save. By default it's enabled.
  let g:go_mod_fmt_autosave = 1


" Use this option to run `godoc` on words under the cursor with |K|; this will normally run the `man` program, but for Go using `godoc` is more idiomatic.  Default is enabled.
  let g:go_doc_keywordprg_enabled = 1
" Maximum height for the GoDoc window created with |:GoDoc|. Default is 20.
  let g:go_doc_max_height = 20
" godoc server URL used when |:GoDocBrowser| is used. Change if you want to use a private internal service. Default is 'https://godoc.org'.
  " let g:go_doc_url = 'https://godoc.org'
" Use this option to use the popup-window for |K| and |:GoDoc|, rather than the |preview-window|. Default is disabled.
  let g:go_doc_popup_window = 0


" Use this option to define the command to be used for |:GoDef|. By default `gopls` is used, because it is the fastest.
" One might also use `guru` for its accuracy or `godef` for its performance. Valid options are `godef`, `gopls`, and `guru`.
  let g:go_def_mode = 'gopls'

" Use this option to define the command to be used for |:GoReferrers|. By default `gopls` is used, because it is the fastest and works with Go modules.
" One might also use `guru` for its ability to show references from other packages.  This option will be removed after `gopls` can show references from
" other packages. Valid options are `gopls` and `guru`. By default it's `gopls`.
  let g:go_referrers_mode = 'gopls'

" Use this option to define the command to be used for |:GoImplements|.  The Implements feature in gopls is still new and being worked upon.
" Valid options are `gopls` and `guru`. By default it's `guru`.
  let g:go_implements_mode = 'gopls'

" Use this option to enable/disable the default mapping of CTRL-], <C-LeftMouse>, g<C-LeftMouse> and (`gd`) for GoDef and CTRL-t for :GoDefPop.  Default is enabled.
  let g:go_def_mapping_enabled = 1

" Use this option to jump to an existing buffer for the split, vsplit and tab mappings of |:GoDef|. By default it's disabled.
  let g:go_def_reuse_buffer = 1

" Use this option to change default path for vim-go tools when using |:GoInstallBinaries| and |:GoUpdateBinaries|. If not set `$GOBIN` or `$GOPATH/bin` is used.
  " let g:go_bin_path = ""

" This option lets |'g:go_bin_path'| (or its default value) take precedence over $PATH when invoking a tool command such as |:GoFmt| or |:GoImports|. By default it is enabled.
" Enabling this option ensures that the binaries installed via |:GoInstallBinaries| and |:GoUpdateBinaries| are the same ones that are invoked via the tool commands.
  let g:go_search_bin_path_first = 1

" Define the snippet engine to use. The default is to auto-detect one. Valid values are:
  " automatic      Automatically detect a snippet engine.
  " ultisnips      https://github.com/SirVer/ultisnips
  " neosnippet     https://github.com/Shougo/neosnippet.vim
  " minisnip       https://github.com/joereynolds/vim-minisnip
  let g:go_snippet_engine = "automatic"

" Use this option to disable updating dependencies with |:GoInstallBinaries|. By default this is enabled.
  let g:go_get_update = 1

" Use this option to define the scope of the analysis to be passed for guru related commands, such as |:GoImplements|, |:GoCallers|, etc. You can change it on-the-fly with |:GoGuruScope|.
" By default it's not set, so the relevant commands' defaults are being used.
  " let g:go_guru_scope = []

" Space-separated list of build tags passed to the `-tags` flag of tools that support it.
" There is also the |:GoBuildTags| convenience command to change or remove build tags.
  " let g:go_build_tags = ''

" Automatically modify GOPATH for certain directory structures, such as for the `godep` tool which stores dependencies in the `Godeps` folder.
" What this means is that all tools are now working with the newly modified GOPATH. So |:GoDef| for example jumps to the source inside the `Godeps` (vendored) source. Currently `godep` and `gb` are supported. By default it's disabled.
  let g:go_autodetect_gopath = 0

" Adds custom text objects. By default it's enabled.
  let g:go_textobj_enabled = 1
" Consider the comment above a function to be part of the function when using the `af` text object and `[[` motion. By default it's enabled.
  let g:go_textobj_include_function_doc = 1
" Consider the variable of an function assignment to be part of the anonymous function when using the `af` text object. By default it's enabled. >
  let g:go_textobj_include_variable = 1

" Use this option to auto |:GoMetaLinter| on save. Only linter messages for the active buffer will be shown.  By default it's disabled.
  let g:go_metalinter_autosave = 0
" Specifies the enabled linters for auto |:GoMetaLinter| on save. By default it's using `vet` and `golint`.
  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" Specifies the linters to enable for the |:GoMetaLinter| command. By default it's using `vet`, `golint` and `errcheck`. >
  let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" Overrides the command to be executed when |:GoMetaLinter| is called. By default it's `golangci-lint`. Valid options are `golangci-lint` and `gopls`.
" When the value is `gopls`, users may want to consider setting `g:go_gopls_staticcheck`.  It can also be used as an advanced setting for users who want to have more control over the metalinter.
  let g:go_metalinter_command = "golangci-lint"
" Overrides the maximum time the linters have to complete. By default it's 5 seconds.
  let g:go_metalinter_deadline = "5s"


" Specifies the type of list to use for command outputs (such as errors from builds, results from static analysis commands, etc...).
" The list type for specific commands can be overridden with |'g:go_list_type_commands'|. The default value (empty) will use the appropriate kind of list for the command that was called.
" Supported values are "", "quickfix", and "locationlist".
  let g:go_list_type = "quickfix"
" Specifies the window height for the quickfix and location list windows. The default value (empty) automatically sets the height to the number of items (maximum up to 10 items to prevent large heights).
  let g:go_list_height = 0

" Specifies the type of list to use for command outputs (such as errors from builds, results from static analysis commands, etc...).
" When an expected key is not present in the dictionary, |'g:go_list_type'| will be used instead.
" Supported keys are "GoBuild", "GoErrCheck", "GoFmt", "GoModFmt", "GoInstall", GoLint", "GoMetaLinter", "GoMetaLinterAutoSave", "GoModifyTags" (used for both :GoAddTags and :GoRemoveTags), "GoRename", "GoRun", and "GoTest".
" Supported values for each command are "quickfix" and "locationlist".
  let g:go_list_type_commands = {}
"   let g:go_list_type = "locationlist"
"   let g:go_list_type_commands = {"GoBuild": "quickfix"}

" Specifies whether the quickfix/location list should be closed automatically in the absence of errors.  The default value is 1.
  let g:go_list_autoclose = 1

" Use this option to auto |:AsmFmt| on save. By default it's disabled.
  let g:go_asmfmt_autosave = 0

" The default command used to open a new terminal for go commands such as |:GoRun|.  The default is `:vsplit`.
  let g:go_term_mode = "vsplit"
" Controls the height and width of a terminal split, respectively.  Applicable to Neovim and Vim with `terminal` feature only.
" By default these are not set, meaning that the height and width are set automatically by the editor.
  let g:go_term_width = 30
  let g:go_term_height = 30
" Causes some types of jobs to run inside a new terminal according to |'g:go_term_mode'|. By default it is disabled.
" Applicable to Neovim and Vim with `terminal` feature only.
  let g:go_term_enabled = 0
" Closes the terminal after the command run in it exits when the command fails.  By default it is enabled.
  let g:go_term_close_on_exit = 1

" Specifies the command that |:GoAlternate| uses to open the alternate file.  By default it is set to edit.
  let g:go_alternate_mode = "edit"

" Use this option to define which tool is used to rename. By default `gorename` is used. Valid options are `gorename` and `gopls`.
  let g:go_rename_command = 'gopls'

" Expression to prefill the new identifier when using |:GoRename| without any arguments. Use an empty string if you don't want to prefill anything.
" By default it converts the identifier to camel case but preserves the capitalisation of the first letter to ensure that the exported state stays the same.
  let g:go_gorename_prefill = 'expand("<cword>") =~# "^[A-Z]"' .
        \ '? go#util#pascalcase(expand("<cword>"))' .
        \ ': go#util#camelcase(expand("<cword>"))'


" Specifies whether `gopls` can be used by vim-go. By default gopls is enabled.  When gopls is disabled completion will not work and other configuration options may also need to be adjusted.
  let g:go_gopls_enabled = 1
" TODO: enable share gopls among mulitple plugins.
" The commandline arguments to pass to gopls. By default, it's an empty array.
  let g:go_gopls_options = []


" The analyses settings for `gopls`. By default, it's `v:null`. Valid map values are `v:true` and `v:false`.
  let g:go_gopls_analyses = v:null
" Specifies whether `gopls` should include suggestions from unimported packages.  When it is `v:null`, `gopls`' default will be used. By default it is `v:null`.
  let g:go_gopls_complete_unimported = v:null
" Specifies whether `gopls` should use deep completion. When it is `v:null`, `gopls`' default will be used. By default it is `v:null`.
  let g:go_gopls_deep_completion = v:null
" Specifies how `gopls` should match for completions. Valid values are `v:null`, `fuzzy`, and `caseSensitive`.  When it is `v:null`, `gopls`' default will be used. By default it is `v:null`.
  let g:go_gopls_matcher = v:null
" Specifies whether `gopls` should run staticcheck checks. When it is `v:null`, `gopls`' default will be used. By default it is `v:null`.
  let g:go_gopls_staticcheck = v:null
" Specifies whether `gopls` can provide placeholders for function parameters and struct fields.
" When set, completion items will be treated as anonymous snippets if UltiSnips is installed and configured to be used as |'g:go_snippet_engine'|.
" When it is `v:null`, `gopls`' default will be used.  By default it is `v:null`.
  let g:go_gopls_use_placeholders = v:null
" Specifies whether `gopls` should use a temp modfile and suggest edits rather than modifying the ambient go.mod file.
" When it is `v:null`, `gopls`' default will be used.  By default it is `v:null`.
  let g:go_gopls_temp_modfile = v:null
" Specifies the prefix for imports that `gopls` should consider group separately. When it is `v:null`, `gopls`' default will be used.  By default it is `v:null`.
  let g:go_gopls_local = v:null
" Specifies whether `gopls` diagnostics are enabled. Only the diagnostics for the current buffer will be processed when it is not set; all others will be ignored. By default it is disabled.
  let g:go_diagnostics_enabled = 0
" When a new Go file is created, vim-go automatically fills the buffer content with a Go code template. By default, the templates under the `templates` folder are used.
" This can be changed with the |'g:go_template_file'| and |'g:go_template_test_file'| settings to either use a different file in the same `templates` folder, or to use a file stored elsewhere.
" If the new file is created in an already prepopulated package (with other Go files), in this case a Go code template with only the Go package declaration (which is automatically determined according to the current package) is added.
" To always use the package name instead of the template, enable the |'g:go_template_use_pkg'| setting.
" By default it is enabled.
  let g:go_template_autocreate = 1
" Specifies either the file under the `templates` folder that is used if a new Go file is created. Checkout |'g:go_template_autocreate'| for more info. By default the `hello_world.go` file is used.
" This variable can be set to an absolute path, so the template files don't have to be stored inside the vim-go directory structure. Useful when you want to use different templates for different projects.
  let g:go_template_file = "hello_world.go"
" Like with |'g:go_template_file'|, this specifies the file to use for test tempaltes. The template file should be under the `templates` folder, alternatively absolute paths can be used, too.
" Checkout |'g:go_template_autocreate'| for more info. By default, the `hello_world_test.go` file is used.
  let g:go_template_test_file = "hello_world_test.go"
" Specifies that, rather than using a template, the package name is used if a new Go file is created. Checkout |'g:go_template_autocreate'| for more info.
" By default the template file specified by |'g:go_template_file'| is used.
  let g:go_template_use_pkg = 0

" Only useful if `ctrlp.vim`, `unite.vim`, `denite.nvim` or `fzf` are installed.  This sets which declarations to show for |:GoDecls| (`ctrp.vim`), |unite-decls| (`unite.vim`) and |denite-decls| (`denite.nvim`).
" It is a Comma delimited list.  Possible options are: {func,type}.  The default is:
  let g:go_decls_includes = 'func,type'
" Define the tool to be used for |:GoDecls|. Valid options are `ctrlp.vim`, `fzf`, or an empty string; in which case it will try to autodetect either `ctrlp.vim` or `fzf`.
  let g:go_decls_mode = ''

" Echoes information about various Go commands, such as `:GoBuild`, `:GoTest`, `:GoCoverage`, etc... Useful to disable if you use the statusline integration, i.e: |go#statusline#Show()|. By default it's enabled
  let g:go_echo_command_info = 1
" Use this option to show the identifier information when code completion is done. By default it's enabled. >
" Please note that 'noshowmode' must be set for this feature to work correctly.
  let g:go_echo_go_info = 1

" Specifies the duration of statusline information being showed per package. By default it's 60 seconds. Must be in milliseconds.
  let g:go_statusline_duration = 60000

" Sets the `transform` option for `gomodifytags` when using |:GoAddTags| or if it's being used for snippet expansion of single fields.
" By default "snakecase" is used. Current values are: ["snakecase", "camelcase", "lispcase", "pascalcase", "keep"].
  let g:go_addtags_transform = 'snakecase'

" Sets the `skip-unexported` option for `gomodifytags` when using |:GoAddTags|.
" If set it will prevent `gomodifytags` from adding tags to unexported fields: By default it is disabled.
  let g:go_addtags_skip_unexported = 0

" A list of options to debug; useful for development and/or reporting bugs.
" Currently accepted values:
  " shell-commands     Echo all shell commands that vim-go runs.
  " debugger-state     Expose debugger state in 'g:go_debug_diag'.
  " debugger-commands  Echo communication between vim-go and `dlv`; requests and
  "                    responses are recorded in `g:go_debug_commands`.
  " lsp                Echo communication between vim-go and `gopls`. All
  "                    communication is shown in a dedicated window. When
  "                    enabled before gopls is started, |:GoLSPDebugBrowser| can
  "                    be used to open a browser window to help debug gopls.
  let g:go_debug = []

" vim-go comes with an enhanced version of Vim's Go syntax highlighting.
  " Control syntax-based folding which takes effect when 'foldmethod' is set to `syntax`.
  let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
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
  let g:go_highlight_diagnostic_errors = 1
  let g:go_highlight_diagnostic_warnings = 1
  let g:go_highlight_format_strings = 1
