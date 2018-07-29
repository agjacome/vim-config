setlocal formatoptions=crqj
setlocal textwidth=80

setlocal wildignore+=*/target/*

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

autocmd BufWritePost *.scala silent :EnTypeCheck

nnoremap <localleader>t :EnType<CR>
nnoremap <localleader>df :EnDeclaration<CR>
nnoremap <localleader>do :EnDocBrowse<CR>
