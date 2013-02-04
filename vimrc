" COMPATIBILITY AND PLUGIN LOADING
set nocompatible                " vim defaults instead of vi
set encoding=utf-8              " always use utf

filetype off                    " load plugins via pathogen
call pathogen#infect()
call pathogen#helptags()

set backupdir=~/.vim/backup     " directory to save backup files
set directory=~/.vim/temp       " directory to save swap files

filetype plugin indent on       " enable filetypes and indentation
syntax enable                   " enable syntax highlight

" SETTINGS
set hidden                      " allow dirty background buffers
set autoindent                  " autoindent always
set nowrap                      " don't wrap long lines automatically
set textwidth=80                " default text width is 80 columns
set expandtab                   " raplace tabs with space characters
set tabstop=4                   " a tab is replaced with four spaces
set softtabstop=4               " a softtab is replaced with four spaces
set shiftwidth=4                " autoindent is also four spaces width

" colorscheme
if $TERM =~ "-256color"
    set t_Co=256
    let g:hybrid_use_Xresources = 1
endif
set background=dark
colorscheme hybrid

set number                      " always show line numbers
set ruler                       " show cursor position all time
set showcmd                     " display incomplete commands
set laststatus=2                " always show statusline
set scrolloff=10                " provide some context when editting
set cursorline                  " highlight current line (VERY SLOW)

set list                        " show whitespace characters
set listchars=""                " reset whitespace characters list
set listchars=tab:▸\            " tabs shown as right arrow and spaces
set listchars+=trail:⋅          " trailing whitespaces show as dots
set listchars+=extends:❯        " char to show when line continues right
set listchars+=precedes:❮       " char to show when line continues left
set fillchars+=vert:│           " vertical splits less gap between bars

" statusline format (Replaced by Powerline)
" if has("statusline") && !&cp
"     " File  ModFlag  ROFlag  Line/Lines[Pos%]  Col  GitStatus | CharCode  Buffer
"     set statusline=%f\ %m\ %r
"     set statusline+=\ Line:%l/%L[%p%%]
"     set statusline+=\ Col:%v
"     set statusline+=\ %{fugitive#statusline()}
"     set statusline+=%=\ [%b][0x%B]
"     set statusline+=\ Buf:#%n
" endif

set hlsearch                  " highlight search matches
set incsearch                 " do incremental searching automatically
set ignorecase                " searches are case insensitive...
set smartcase                 " ...unless they contain uppercase letters

" completion options
set complete=.,b,u,]
set wildmode=longest
set completeopt=menu,menuone,longest
set pumheight=10

if has("autocmd")
    " Makefiles should use real tabs, not spaces
    au FileType make set noexpandtab
    " MarkDown files matching their filetype and using second wrap
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt}
                \ setf markdown set wrap wrapmargin=2 textwidth=72
    " Python files should follow PEP8
    au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
    " Remember last location in file (except for commit messages)
    au BufReadPost *
                \ if &filetype !~ '^git\c' && line("'\"") > 0
                \ && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" FUNCTIONS
function! ToggleColours()
if g:colors_name == 'hybrid'
    colorscheme hybrid-light
else
    colorscheme hybrid
endif
endfunction

" MAPPINGS
let mapleader=","
map <F3> :call ToggleColours()<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>
nnoremap <CR> :nohlsearch<CR>
nnoremap <leader>d "=strftime("%d %b %Y %H:%M")<CR>p
nnoremap <leader><leader> <c-^>
cnoremap %% <C-R>=expand('%:h').'/'<cr>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" navigation between split windows with Ctrl+[hjkl]
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" disable cursor keys in normal mode (print 'no!' in cmdline)
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" PLUGIN SETTINGS
" Powerline
let g:Powerline_symbols = 'compatible'

" Command-T
let g:CommandTMaxHeight = 10
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" Clang Complete
let g:clang_complete_auto=0
let g:clang_library_path='/usr/lib/llvm'
let g:clang_use_library=1

" SuperTab
let g:SuperTabDefaultCompletionType='context'
