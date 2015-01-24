source ~/.vim/autofix.vim

setlocal formatoptions+=twn
setlocal spell

set updatetime=1000
autocmd CursorHoldI,CursorHold,BufLeave,FocusLost silent! wall
