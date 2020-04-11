setlocal formatoptions=crqj
setlocal textwidth=80

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal formatexpr=CocAction('formatSelected')

nnoremap <silent> <space>t  :<C-u>CocCommand metals.tvp<CR>
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>

autocmd FileType json syntax match Comment +\/\/.\+$+

