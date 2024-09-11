" https://learnvimscriptthehardway.stevelosh.com/chapters/44.html
"
augroup filetypedetect
  " au! commands to set the filetype go here
  autocmd! BufNewFile,BufReadPost *.vimrc setf vim
  autocmd! BufNewFile,BufReadPost *.x_profile,*.x_shrc setf sh
augroup END
