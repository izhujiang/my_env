" https://github.com/preservim/tagbar/wiki

let g:tagbar_type_css = {
  \ 'ctagstype' : 'Css',
  \ 'kinds'     : [
      \ 'c:classes',
      \ 's:selectors',
      \ 'i:identities'
  \ ]
\ }

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


let g:tagbar_type_javascript = {
  \ 'ctagstype': 'javascript',
  \ 'kinds': [
  \ 'A:arrays',
  \ 'P:properties',
  \ 'T:tags',
  \ 'O:objects',
  \ 'G:generator functions',
  \ 'F:functions',
  \ 'C:constructors/classes',
  \ 'M:methods',
  \ 'V:variables',
  \ 'I:imports',
  \ 'E:exports',
  \ 'S:styled components'
  \ ]}

let g:tagbar_type_json = {
  \ 'ctagstype' : 'json',
  \ 'kinds' : [
    \ 'o:objects',
    \ 'a:arrays',
    \ 'n:numbers',
    \ 's:strings',
    \ 'b:booleans',
    \ 'z:nulls'
  \ ],
  \ 'sro' : '.',
  \ 'scope2kind': {
  \ 'object': 'o',
    \ 'array': 'a',
    \ 'number': 'n',
    \ 'string': 's',
    \ 'boolean': 'b',
    \ 'null': 'z'
  \ },
  \ 'kind2scope': {
  \ 'o': 'object',
    \ 'a': 'array',
    \ 'n': 'number',
    \ 's': 'string',
    \ 'b': 'boolean',
    \ 'z': 'null'
  \ },
  \ 'sort' : 0
\ }