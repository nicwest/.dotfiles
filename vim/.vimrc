
"vundle
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'gitignore'
Bundle 'honza/vim-snippets'
Bundle 'itchyny/lightline.vim'
Bundle 'jaxbot/github-issues.vim'
Bundle 'jpythonfold.vim'
Bundle 'junegunn/goyo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'lord-garbage/tslime.vim'
Bundle 'mattn/emmet-vim'
Bundle 'rking/ag.vim'
Bundle 'scratch.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'w0ng/vim-hybrid'

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
set relativenumber
set number

" toggle relative line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <Leader>l  :call NumberToggle()<cr>

"cursorline
set cursorline

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
set showbreak=↪
set linebreak

" mouse?
set mouse=a
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>

" Pawel says this is important
noremap Q <nop>

"status line
set laststatus=2

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
let g:syntastic_python_flake8_args='--ignore=E501,E225,E226,E265'

" search sanitity
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><BS> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"Y behaves as expected, in accord with C, D etc. 
nnoremap Y y$

"space
nnoremap <Leader><CR> O<C-c>
nmap <c-b> <c-a> "c-a is a tmux prefix so to increment numbers use c-b

" open files
nnoremap <C-p> :CtrlP<CR>
nnoremap <C-f> :CtrlPBuffer<CR>
nnoremap <C-f> :CtrlPBuffer<CR>
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>ff :CtrlPBookmarkDir<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_extensions = ['funky']

"So Wonely....
nnoremap <leader>1 :only<CR>

" write files
nnoremap <Leader>w :w<CR>

" buffer swap
nnoremap <leader><Tab> <C-^>

"reselect pasted text
nnoremap <leader>v V`]

"put under
nnoremap <silent> <leader>pu :pu<CR>

"open ~/.vimrc in split
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>er :source $MYVIMRC<CR>

"open vertical split
nnoremap <leader>S <C-w>v<C-w>l
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

"fugutive binds:
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

"scratch binds
nnoremap <leader>n :Scratch<CR>

"quick fix
nnoremap <silent> <leader>qo :copen<CR>
nnoremap <silent> <leader>qq :cclose<CR>
nnoremap <silent> <leader>qc :cex []<CR>

"norm-insert toggler
"find something useful to bind to these useful buttons!
nmap <F13> :bNext<CR> 
imap <F13> <nop>
vmap <F13> <nop>

nmap <F14> :bnext<CR>
imap <F14> <nop>
vmap <F14> <nop>

nmap <s-F13> <nop>
nmap <s-F14> <nop>

imap <F34> <nop>

"buffer paging
nnoremap [b :bNext<CR>
nnoremap ]b :bnext<CR>

let g:user_emmet_leader_key='<c-y>'

nnoremap L $
nnoremap H ^
vmap L $
vmap H ^
omap L $
omap H ^

"auto set clipboard
if os == 'unix'
    set clipboard=unnamedplus
endif

if os == 'mac'
    set clipboard=unnamed
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
endif

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

function! DjangoTestThis()
    call PythonGetLabel()
    let @" = './manage.py test ' . @0
    if exists("*SendToTmux")
        call SendToTmux(@")
        call ExecuteKeys('')
    endif
endfunction

nnoremap gL :call PythonGetLabel()<CR>
nnoremap <leader>tl :call DjangoTestThis()<CR>

"NerdTree :D
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

"Goyo!
nnoremap <Leader>gy :Goyo<CR>

"spelling stuf
map <leader>so :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>ss z=

"ultisnip
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
nnoremap <Leader>dj :set ft=python.django<CR>
nnoremap <Leader>py :set ft=python<CR>

" auto load files if vim detects they have been changed outside of Vim
set autoread

"you complete me
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"tmux slime
nmap <C-c><C-c> <Plug>ExecuteKeysCc
nmap <C-c><C-x> <Plug>ExecuteKeysCl
nmap <C-c>r <Plug>SetTmuxVars

"use spellchecking when writing md
au BufRead *.md setlocal spell spelllang=en_gb
au BufRead *.markdown setlocal spell spelllang=en_gb

"set tab stops based on file type
autocmd Filetype html,htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype css,scss setlocal ts=2 sts=2 sw=2

"githubissues config
"imap <c-I> <c-x><c-o>

noh
