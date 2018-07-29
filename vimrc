set nocompatible
set encoding=utf-8

if has('python3')
  silent! python3 1
endif

" vim plugins, managed by Plug
filetype off
call plug#begin('~/.vim/plugged')

Plug 'chrisbra/csv.vim'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'kien/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-colors-off'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sirver/ultisnips'
Plug 'suan/vim-instant-markdown'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/gitignore'
Plug 'vim-scripts/visincr'

call plug#end()
filetype plugin indent on
syntax enable

" main settings
set autoindent
set autoread
set autowrite
set backspace=2
set complete=.,b,u,]
set completeopt=longest,menu
set directory=/tmp
set expandtab
set fillchars+=vert:│
set foldmethod=manual
set formatoptions+=j
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars+=extends:❯
set listchars+=nbsp:.
set listchars+=precedes:❮
set listchars+=trail:.
set listchars=""
set listchars=tab:.\
set magic
set nobackup
set nofoldenable
set nojoinspaces
set nowrap
set nowritebackup
set numberwidth=2
set pumheight=10
set relativenumber
set ruler
set scrolloff=10
set shiftwidth=4
set shortmess+=cI
set showcmd
set smartcase
set softtabstop=4
set t_ti= t_te=
set tabstop=4
set tags=./.tags,.tags,./tags,tags;/
set textwidth=79
set timeoutlen=300
set title
set titleold=""
set titlestring="vim: %F"
set undodir=~/.vim/undo
set undofile
set undolevels=100
set undoreload=10000
set updatetime=300
set virtualedit=block
set wildmode=longest,list

let &showbreak = '↳ '

" colorscheme
set t_ut=
set t_Co=256
set background=dark
colorscheme hybrid
highlight clear conceal

" vimdiff
if &diff
    set diffopt=filler
endif

" restore cursor position when reopening a file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g`\"" |
    \ endif

" check external modifications when inactive
autocmd CursorHold * checktime

" functions
function! ToggleColors()
    if g:colors_name == 'hybrid'
        set background=dark
        colorscheme off
        AirlineTheme zenburn
        highlight clear conceal
    elseif g:colors_name == 'off'
        set background=light
        colorscheme hybrid-light
        AirlineTheme hybrid
        highlight clear conceal
    else
        set background=dark
        colorscheme hybrid
        AirlineTheme hybrid
        highlight clear conceal
    endif
endfunction

function! ToggleNumbers()
    if (&relativenumber == 1)
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunction

function! ToggleHex()
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1

    if !exists("b:editHex") || !b:editHex
        let b:oldft=&ft
        let b:oldbin=&bin
        setlocal binary
        let &ft="xxd"
        let b:editHex=1
        %!xxd
    else
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        let b:editHex=0
        %!xxd -r
    endif

    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

function! ToggleConceal()
    if &conceallevel >= 1
        set conceallevel=0 concealcursor=
    else
        set conceallevel=1 concealcursor=
    endif
endfunction

command! KillWhitespace :normal :%s/\s\+$//ge<cr><c-o><cr>

" mappings
let mapleader=","
let maplocalleader=";"
noremap ,, ,

nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" navigation between split windows with Ctrl+[hjkl]
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" open split windows in places with leader+[HJKL]
nnoremap <silent><leader>H :leftabove vnew<cr>
nnoremap <silent><leader>L :rightbelow vnew<cr>
nnoremap <silent><leader>K :leftabove new<cr>
nnoremap <silent><leader>J :rightbelow new<cr>

" navigation between buffers (Tab and Shift+Tab)
nnoremap <silent><tab> :bnext<cr>
nnoremap <silent><s-tab> :bprevious<cr>

" disable cursor keys in normal mode (print 'no!' in cmdline)
noremap <Left>  :echo "no!"<cr>
noremap <Right> :echo "no!"<cr>
noremap <Up>    :echo "no!"<cr>
noremap <Down>  :echo "no!"<cr>

" simple delimitmate
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O
inoremap {<Space> { }<Left>
inoremap [<Space> [ ]<Left>
inoremap (<Space> ( )<Left>

noremap <leader>m :make<cr>
noremap <silent><leader>k :KillWhitespace<cr>
noremap <silent><leader>r :redraw!<cr>

nnoremap <silent><leader>p :set invpaste<cr>
nnoremap <silent><leader>c :call ToggleConceal()<cr>

noremap <f5> :call ToggleColors()<cr>
noremap <f6> :call ToggleNumbers()<cr>
noremap <f7> :call ToggleHex()<cr>
noremap <f8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

cnoremap <c-j> <t_kd>
cnoremap <c-k> <t_ku>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap %% <c-r>=expand('%:p:h').'/'<cr>

nnoremap <silent><cr> :nohlsearch<cr>
nnoremap <silent><leader>D "=strftime("%d %b %Y %H:%M")<cr>p
nnoremap <silent><leader>b <c-^>
nnoremap Q <nop>

" plugin settings

" Airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Conquer of Completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent>[c <Plug>(coc-diagnostic-prev)
nmap <silent>]c <Plug>(coc-diagnostic-next)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gy <Plug>(coc-type-definition)

nnoremap <silent><space>a :<C-u>CocList diagnostics<cr>
nnoremap <silent><space>o :<C-u>CocList outline<cr>
nnoremap <silent><space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent><space>j :<C-u>CocNext<CR>
nnoremap <silent><space>k :<C-u>CocPrev<CR>
nnoremap <silent><space>p :<C-u>CocListResume<CR>

nnoremap <silent> F :call CocAction('format')<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')


" Ctrl-P
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = [ '.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard' ]
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 0

" EasyAlign
vmap <Enter>   <Plug>(LiveEasyAlign)
nmap <leader>a <Plug>(LiveEasyAlign)

" Emmet
let g:user_emmet_mode = 'a'

" JavaScript
let g:javascript_fold = 0
let g:javascript_enable_domhtmlcss = 1

" JSX
let g:jsx_ext_required = 0

" NerdCommenter
let g:NERDCreateDefaultMappings = 1
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1

" NerdTree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1

function! ToggleFindNERD()
    if exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
        exec ':NERDTreeToggle'
    else
        exec ':NERDTreeFind'
    endif
endfunction

noremap <silent><leader>f :call ToggleFindNERD()<cr>
noremap <silent><leader>F :NERDTreeToggle<cr>

" Scala
let g:scala_sort_across_groups = 1

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_haskell_checkers = ['hlint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
noremap <silent><leader>e :Errors<cr>
noremap <silent><leader>S :SyntasticToggleMode<cr>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsForwardTrigger="<c-j>"
let g:UltiSnipsBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
