" vim-prettier settings
" Disable auto formatting of files that have "@format" tag
let g:prettier#autoformat = 0
" The command :Prettier by default is synchronous but can also be forced async
let g:prettier#exec_cmd_async = 1
" By default parsing errors will open the quickfix but can also be disabled
let g:prettier#quickfix_enabled = 0
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 80
" " number of spaces per indentation level
let g:prettier#config#tab_width = 2
" use tabs over spaces
let g:prettier#config#use_tabs = 'false'
" " print semicolons
let g:prettier#config#semi = 'true'
" single quotes over double quotes
let g:prettier#config#single_quote = 'true'
" print spaces between brackets
let g:prettier#config#bracket_spacing = 'false'
" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'true'
" none|es5|all
let g:prettier#config#trailing_comma = 'all'
" flow|babylon|typescript|postcss
let g:prettier#config#parser = 'flow'
" always|never|preserve
" let g:prettier#config#prose_wrap = 'preserve'

" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
