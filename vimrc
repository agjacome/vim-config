set nocompatible                " vim defaults instead of vi
set encoding=utf-8              " always use utf

filetype off

" vim plugins, managed by vundle
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'adimit/prolog.vim'
Plugin 'bling/vim-airline'
Plugin 'chrisbra/csv.vim'
Plugin 'dag/vim2hs'
Plugin 'derekwyatt/vim-scala'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'elzr/vim-json'
Plugin 'flazz/vim-colorschemes'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/vim-easy-align'
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'latex-box-team/latex-box'
Plugin 'lnl7/vim-nix'
Plugin 'pbrisbin/vim-colors-off'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'shougo/vimproc.vim'
Plugin 'sirver/ultisnips'
Plugin 'suan/vim-instant-markdown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/gitignore'
Plugin 'vim-scripts/visincr'

call vundle#end()

filetype plugin indent on       " enable filetypes and indentation
syntax enable                   " enable syntax highlight

set directory=/tmp              " directory to save swap files
set undodir=~/.vim/undo         " directory to save undo buffers
set nobackup                    " do not create any...
set nowritebackup               " ...backup files

" MAIN SETTINGS
set hidden                      " allow unsaved background buffers
set autoindent                  " autoindent always
set autowrite                   " autowrite file modifications
set autoread                    " automatically reload external modifications
set history=10000               " remember more commands and search history
set undofile                    " save undos buffer to file
set undolevels=100              " max number of changes to undo
set undoreload=10000            " max number of lines to reload for undo
set backspace=2                 " make backspace work as intended
set nowrap                      " don't wrap long lines automatically
set textwidth=79                " default text width is 79 columns
set expandtab                   " replace tabs with space characters
set tabstop=4                   " a tab is replaced with four spaces
set softtabstop=4               " a softtab is replaced with four spaces
set shiftwidth=4                " autoindent is also four spaces width
set hlsearch                    " highlight search matches
set incsearch                   " do incremental searching automatically
set ignorecase                  " searches are case insensitive...
set smartcase                   " ...unless they contain uppercase letters
set formatoptions+=j            " remove comments when joining lines
set nojoinspaces                " only one space when joining punctuation-ended lines
set foldmethod=manual           " set folding to manual, never autofold
set nofoldenable                " disable folding
set updatetime=1000             " wait time to write swap and call CursorHold (in ms)
set timeoutlen=300              " wait time for a key code to complete (in ms)
set lazyredraw                  " do not update display while executing macros
set magic                       " enable magic mode for regular expressions

" prevent vim from clobbering scrollback buffer
set t_ti= t_te=

" completion options
set complete=.,b,u,]
set wildmode=longest,list
set completeopt=longest,menu
set pumheight=10

" colorscheme
if $TERM =~ "-256color"
    set t_ut= t_Co=256
    let g:hybrid_use_Xresources = 1
endif
set background=dark
colorscheme hybrid

" vimdiff
if &diff
    set diffopt=filler
endif

" show title
set title
set titleold=""
set titlestring="vim: %F"

set shortmess+=I                " disable startup message
set relativenumber              " always show relative line numbers
set numberwidth=2               " number of digits for line numbers
set ruler                       " show cursor position all time
set showcmd                     " display incomplete commands
set laststatus=2                " always show statusline
set scrolloff=10                " provide some context
" set cursorline                " highlight current line

set list                        " show whitespace characters
set listchars=""                " reset whitespace characters list
set listchars=tab:▸\            " tabs shown as right arrow and spaces
set listchars+=trail:⋅          " trailing whitespaces shown as dots
set listchars+=nbsp:⋅           " non-breakable spaces shown as dots
set listchars+=extends:❯        " char to show when line continues right
set listchars+=precedes:❮       " char to show when line continues left
set fillchars+=vert:│           " vertical splits less gap between bars
let &showbreak = '↳ '           " char to show at start of wrapped lines

set tags=./.tags,.tags,./tags,tags;/

" restore cursor position when reopening a file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g`\"" |
    \ endif

" check external modifications when inactive
autocmd CursorHold * checktime

" FUNCTIONS
function! ToggleColors()
    if g:colors_name == 'hybrid'
        colorscheme off
        AirlineTheme zenburn
    elseif g:colors_name == 'off'
        colorscheme hybrid-light
        AirlineTheme hybrid
    else
        colorscheme hybrid
        AirlineTheme hybrid
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

command! KillWhitespace :normal :%s/\s\+$//g<cr><c-o><cr>

" MAPPINGS
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" navigation between split windows with Ctrl+[hjkl]
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" open split windows in places with Leader+s[hjkl]
nmap <Leader>sh :leftabove vnew<CR>
nmap <Leader>sl :rightbelow vnew<CR>
nmap <Leader>sk :leftabove new<CR>
nmap <Leader>sj :rightbelow new<CR>

" navigation between buffers (Tab and Shift+Tab)
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" disable cursor keys in normal mode (print 'no!' in cmdline)
map <Left>  :echo "no!"<CR>
map <Right> :echo "no!"<CR>
map <Up>    :echo "no!"<CR>
map <Down>  :echo "no!"<CR>

" simple delimitmate
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap {<Space> { }<Left>
inoremap [<Space> [ ]<Left>
inoremap (<Space> ( )<Left>

let mapleader=","
noremap ,, ,

map <Leader>m :make<CR>
map <Leader>k :KillWhitespace<CR>
map <Leader>r :redraw!<CR>

map <F3> :call ToggleColors()<CR>
map <F4> :call ToggleNumbers()<CR>
map <F6> :call ToggleHex()<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <CR> :nohlsearch<CR>
nnoremap <Leader>d "=strftime("%d %b %Y %H:%M")<CR>p
nnoremap <Leader>b <c-^>
nnoremap Q <nop>

" PLUGIN SETTINGS
" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Ctrl-P
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = [ '.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard' ]
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 0

" EasyAlign
vmap <Enter>   <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

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

map <silent> <Leader>f :call ToggleFindNERD()<CR>
map <silent> <Leader>F :NERDTreeToggle<CR>

" Scala
let g:scala_sort_across_groups = 1
let g:scala_first_party_namespaces = 'es.uvigo.*'

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"

" Vim2Hs
let g:haskell_conceal_enumerations = 0
hi clear Conceal
