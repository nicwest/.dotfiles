
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
Bundle 'Raimondi/delimitMate'
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
    if s:uname == "Darwin\n"
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

" color scheme
syntax enable
set t_Co=256
set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid

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
set scrolloff=15
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
"nnoremap ; :

"macro remap
nnoremap , @
nnoremap ,, @@

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
nnoremap <leader>er :source $MYVIMRC<CR>

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

"escape keys!
if os == "win"
    imap <s-Space> <ESC>
    vmap <c-Space> <ESC>
endif


"fugutive binds:
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

"scratch binds
nnoremap <leader>n :Scratch

"norm-insert toggler
"find something useful to bind to these useful buttons!
nmap <F13> <nop>
imap <F13> <nop>
vmap <F13> <nop>

nmap <F14> <nop>
imap <F14> <nop>
vmap <F14> <nop>

nmap <s-F13> <nop>
nmap <s-F14> <nop>

imap <F34> <nop>

"buffer paging
nnoremap <c-Left> :bNext<CR>
nnoremap <c-Right> :bnext<CR>

let g:user_emmet_leader_key='<c-y>'

nnoremap L $
nnoremap H ^
vmap L $
vmap H ^

"auto unfold
"au BufRead * normal zR

"auto set clipboard
if os == 'unix'
    set clipboard=unnamedplus
endif

if os == 'mac'
    set clipboard=unnamed
endif

"Ctrl+P settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"https://gist.github.com/nicwest/11081513
function! PythonGetLabel()
    if foldlevel('.') != 0
        norm! zo
    endif
    let originalline = getpos('.')
    let lnlist = [] 
    let lastlineindent = indent(line('.'))
    let objregexp = "^\\s*\\(class\\|def\\)\\s\\+[^:]\\+\\s*:"
    if match(getline('.'),objregexp) != -1
        let lastlineindent = indent(line('.'))
        norm! ^wye
        call insert(lnlist, @0, 0)
    endif
    while line('.') > 1
        if indent('.') < lastlineindent
            if match(getline('.'),objregexp) != -1
                let lastlineindent = indent(line('.'))
                norm! ^wye
                call insert(lnlist, @0, 0)
            endif
        endif
        norm! k
    endwhile
    let pathlist =  split(expand('%:r'), '/')
    echo 'Python label: ' join(pathlist + lnlist, '.')
    let @0 = join(pathlist + lnlist, '.')
    let @+ = @0
    call setpos('.', originalline)
endfunction

nnoremap gL :call PythonGetLabel()<CR>
