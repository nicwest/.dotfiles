
"vundle
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'gmarik/vundle'
Bundle 'jpythonfold.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mhinz/vim-signify'
" Bundle 'nvie/vim-flake8'
Bundle 'python.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'scrooloose/syntastic'
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'

filetype plugin indent on     " required

" solarised
syntax enable
set t_Co=256
set background=dark
colorscheme molokai

let g:molokai_original = 1
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

nnoremap <C-l> :call NumberToggle()<cr>

" indents and auto-indent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" 80 char ruler
set colorcolumn=80

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
