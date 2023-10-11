" EditorConfig plugin for Vim http://editorconfig.org

" To ensure that this plugin works well with Tim Pope's fugitive, use the following patterns array:
" let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" If you wanted to avoid loading EditorConfig for any remote files over ssh:
" let g:EditorConfig_exclude_patterns = ['scp://.*']
" Of course these two items could be combined into the following:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" resolve conflicts of trailing whitespace trimming and buffer autosaving.
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
" You are able to disable any supported EditorConfig properties.
