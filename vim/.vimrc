
"vundle
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'scratch.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'itchyny/lightline.vim'
Bundle 'edkolev/tmuxline.vim'
Bundle 'ervandew/supertab'
Bundle 'gitignore'
Bundle 'gmarik/vundle'
Bundle 'jpythonfold.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-expand-region'
Bundle 'w0ng/vim-hybrid'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'

filetype plugin indent on     " required

" Get running OS
let os = ""
if has("win32")
  let os="win"
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin"
      let os="mac"
    else
      let os="unix"
    endif
  endif
endif

if os=="unix"
    set <F13>=[25~
    set <F14>=[26~
    set <s-F13>=[25;2~ 
    set <s-F14>=[26;2~
    set <F33>=[25;5~
    set <F34>=[26;5~
endif
" solarised
syntax enable
set t_Co=256
set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid
"colorscheme molokai 

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

nnoremap <Leader>n :call ResetandCheck()<CR>

" search sanitity
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><BS> :noh<cr>
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
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

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
nnoremap <leader>8 :vertical resize 80<CR>
nnoremap <leader>9 :vertical resize 90<CR>
nnoremap <leader>0 :vertical resize 100<CR>

"folding and things
nnoremap <leader><leader> za
nnoremap <leader>r zr
nnoremap <leader>m zm

"move around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"norm-insert toggler
nmap <F13> ^
imap <F13> <ESC>
vmap <F13> <ESC>

nmap <F14> $
imap <F14> <ESC>
vmap <F14> <ESC>

nmap <s-F13> :bNext<CR>
nmap <s-F14> :bnext<CR>

imap <F34> <C-y>,
"let g:user_emmet_leader_key='<F34>'

"auto unfold
au BufRead * normal zR

"auto set clipboard
set clipboard=unnamedplus

"Ctrl+P settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

