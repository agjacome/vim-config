set nocompatible                " vim defaults instead of vi
set encoding=utf-8              " always use utf

" load submodules via pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set backupdir=~/.vim/backup     " directory to save backup files
set undodir=~/.vim/undo         " directory to save undo buffers
set directory=~/.vim/temp       " directory to save swap files

filetype plugin indent on       " enable filetypes and indentation
syntax enable                   " enable syntax highlight

" MAIN SETTINGS
set autoindent                  " autoindent always
set autowrite                   " autowrite file modifications
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

" completion options
set complete=.,b,u,]
set wildmode=longest,list
set completeopt=menu
set pumheight=10

" colorscheme
if $TERM =~ "-256color"
    set t_Co=256
    let g:hybrid_use_Xresources = 1
endif
set background=dark
colorscheme hybrid

" vimdiff
if &diff
    set diffopt=filler,foldcolumn:0
endif

" show title
set title
set titleold=""
set titlestring="vim: %F"

set relativenumber              " always show relative line numbers
set numberwidth=2               " number of digits for line numbers
set ruler                       " show cursor position all time
set showcmd                     " display incomplete commands
set laststatus=2                " always show statusline
set scrolloff=10                " provide some context
set cursorline                  " highlight current line

set list                        " show whitespace characters
set listchars=""                " reset whitespace characters list
set listchars=tab:▸\            " tabs shown as right arrow and spaces
set listchars+=trail:⋅          " trailing whitespaces shown as dots
set listchars+=extends:❯        " char to show when line continues right
set listchars+=precedes:❮       " char to show when line continues left
set fillchars+=vert:│           " vertical splits less gap between bars

if has("autocmd")
    " makefiles should use real tabs, not spaces
    au FileType make set noexpandtab
    " restore cursor position when reopening a file
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     exe "normal g`\"" |
        \ endif
endif

" FUNCTIONS
function! ToggleColours()
    if g:colors_name == 'hybrid'
        colorscheme hybrid-light
    else
        colorscheme hybrid
    endif
endfunction

function! ToggleNumbers()
    if (&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunction

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" MAPPINGS
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" navigation between split windows with Ctrl+[hjkl]
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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

map <Leader>m :make<CR>
map <F3> :call ToggleColours()<CR>
map <F4> :call ToggleNumbers()<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <CR> :nohlsearch<CR>
nnoremap <leader>d "=strftime("%d %b %Y %H:%M")<CR>p
nnoremap <leader><leader> <c-^>

" PLUGIN SETTINGS
" Clang Complete
set tags+=/usr/include/tags
let g:clang_complete_auto=0
let g:clang_library_path='/usr/lib/llvm'
let g:clang_use_library=1

" NerdCommenter
let g:NERDCreateDefaultMappings = 1
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1

" NerdTree
map <Leader>f :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Powerline
let g:Powerline_symbols = 'compatible'

" SuperTab
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'
