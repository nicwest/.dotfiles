
"vundle
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'gitignore'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'gmarik/vundle'
Bundle 'jpythonfold.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'python.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'terryma/vim-expand-region'
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'

filetype plugin indent on     " required

" solarised
syntax enable
set t_Co=256
set background=dark
colorscheme molokai 

"let g:molokai_original = 1

"LEADER
let mapleader = "\<Space>"

" line numbers
set number

" toggle relative line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunc

nnoremap <Leader>l  :call NumberToggle()<cr>

" indents and auto-indent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" 80 char ruler
set colorcolumn=80

" rational vim
set backspace=indent,eol,start
set scrolloff=3
set showmode
set hidden
set encoding=utf-8
set wildmenu
set wildmode=longest:full,full
set visualbell
set ttyfast
set undofile

" ruler
" set ruler

" mouse?
set mouse=a
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>

" Pawel says this is important
noremap Q <nop>

"status line
set laststatus=2

" airline
let g:airline_powerline_fonts = 1

set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
   call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
   call mkdir(expand(&directory), "p")
endif

autocmd FileType python source ~/.vim/bundle/jpythonfold.vim/syntax/jpythonfold.vim
let g:syntastic_python_checkers = ['flake8']

" syntastic reset and recheck
function! ResetandCheck()
    SyntasticReset
    SyntasticCheck
endfunc

nnoremap <Leader>c :call ResetandCheck()<CR>

" search sanitity
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"colon remap
nnoremap ; :

" open files
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>i :CtrlPBuffer<CR>

"So Wonely....
nnoremap <leader>1 :only<CR>

" write files
nnoremap <Leader>w :w<CR>

" buffer swap
nnoremap <leader><Tab> <C-^>

"strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"reselect pasted text
nnoremap <leader>v V`]

"open ~/.vimrc in split
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"open vertical split
nnoremap <leader>s <C-w>v<C-w>l

"move around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"auto unfold
au BufRead * normal zR

"auto set clipboard
set clipboard=unnamed

"Ctrl+P settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0


" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

