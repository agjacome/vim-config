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
set completeopt=menuone,preview
set pumheight=10

" colorscheme
if $TERM =~ "-256color"
    set t_Co=256
    let g:hybrid_use_Xresources = 1
endif
set background=dark
colorscheme hybrid

" show title
set title
set titleold=""
set titlestring="vim: %F"

set number                      " always show line numbers
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

" statusline format (replaced by powerline)
" if has("statusline") && !&cp
"     set statusline=%f\ %m\ %r
"     set statusline+=\ Line:%l/%L[%p%%]
"     set statusline+=\ Col:%v
"     set statusline+=\ %{fugitive#statusline()}
"     set statusline+=%=\ [%b][0x%B]
"     set statusline+=\ Buf:#%n
" endif

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

function! Rename(dest)
    if &modified
        echoe "buffer is modified"
        return
    endif

    if len(glob(a:dest))
        echoe "destination already exists"
        return
    endif

    let filename = expand("%:p")
    let parent = fnamemodify(a:dest, ":p:h")

    if !isdirectory(parent)
        call mkdir(parent, "p")
    endif

    exec "saveas " . a:dest
    call delete(filename)
endfunction

command! -nargs=1 -complete=file Rename call Rename(<f-args>)
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

" rson's delimitmate
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

let mapleader=","

map <Leader>m :make<CR>
map <F3> :call ToggleColours()<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <CR> :nohlsearch<CR>
nnoremap <leader>d "=strftime("%d %b %Y %H:%M")<CR>p
nnoremap <leader><leader> <c-^>

" PLUGIN SETTINGS
" Clang Complete
let g:clang_complete_auto=0
let g:clang_library_path='/usr/lib/llvm'
let g:clang_use_library=1

" Command-T
let g:CommandTMaxHeight = 10
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" NerdCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1
map <Leader>c <plug>NERDCommenterToggle

" Powerline
let g:Powerline_symbols = 'compatible'

" SuperTab
let g:SuperTabDefaultCompletionType='context'

