" vim:fdm=marker
" Plug {{{
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'FuzzyFinder'
Plug 'L9'
Plug 'Raimondi/delimitMate'
Plug 'chase/vim-ansible-yaml'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'jpythonfold.vim'
Plug 'luochen1990/rainbow'
Plug 'nicwest/tslime.vim'
Plug 'majutsushi/tagbar'
"Plug 'nicwest/vim-arrow'
Plug '/home/nic/sideprojects/vim-workman'
Plug '/home/nic/sideprojects/vim-requester'
Plug 'nicwest/vim-after-syntax-vim'
Plug 'nicwest/QQ.vim'
Plug 'nicwest/cocoa.vim', {'branch': 'syntax-only'}
Plug 'nicwest/vim-bnext'
Plug 'git@github.com:nicwest/template-bucket.git'
Plug 'nicwest/vim-flake8'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'w0ng/vim-hybrid'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'scrooloose/syntastic'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-projectionist'
Plug 'wellle/targets.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-jp/vital.vim'
Plug '/home/nic/sideprojects/vim-git-appraise'

"Bundle 'file:///Users/nic/Sideprojects/QQ.vim'
call plug#end()

filetype plugin indent on     " required

" }}}
" Utilities {{{

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
" }}}
" Colors {{{

" color scheme
syntax enable
set t_Co=256
set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" }}}
" Settings {{{

" line numbers
set relativenumber
set nonumber

" wrapping off, this might be a bad idea, lets see how it goes
set nowrap

"cursorline
set cursorline

" indents and auto-indent
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
set novisualbell
set ttyfast

" path wildcards
set path=**

"set showbreak=↪
set showbreak=>
set linebreak

"status line
set laststatus=2

" backups, swaps, and undos
set undofile
set backup
set noswapfile
set undodir=~/.vim/tmp/undo/
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/

" mouse?
set mouse=a

" search sanitity
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" }}}
" Functions {{{

" toggle relative line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

"toggle line wrapping
function! WrapToggle()
    if(&formatoptions=='cat')
        set formatoptions=croql
        echo 'not wrapping'
    else
        set formatoptions=cat
        echo 'wrapping'
    endif
endfunc

"toggle line centering
function! ScrollOffToggle()
    if(&scrolloff != 999)
        norm! zz
        set scrolloff=999
    else
        set scrolloff=3
    endif
    echo &scrolloff
endfunc 

" Modeline after last buffer
function! AppendModeline()
    let l:modeline = printf(" vim: set ft=%s ts=%d sw=%d tw=%d %s %set",
                \ &filetype, &tabstop, &shiftwidth, &textwidth,
                \ &fdm == 'manual' || &fdm == 'marker' ? 'fdm=marker' : '',
                \ &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction

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
    norm! ^wyt(
    call insert(lnlist, @0, 0)
  endif
  while line('.') > 1
    if indent('.') < lastlineindent
      if match(getline('.'),objregexp) != -1
        let lastlineindent = indent(line('.'))
        norm! ^wyt(
        call insert(lnlist, @0, 0)
      endif
    endif
    norm! k
  endwhile
  let pathlist =  split(expand('%:r'), '/')
  "echo 'Python label: ' join(pathlist + lnlist, '.')
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

function! PyTestThis()
  if exists("*SendToTmux")
    call SendToTmux('py.test ' . expand('%'))
    call ExecuteKeys('')
  endif
endfunction

function! ThemisTestThis()
  if exists("*SendToTmux")
    call SendToTmux('vim-themis/bin/themis --reporter dot '.expand('%'))
    call ExecuteKeys('')
  endif
endfunction

function! OpenCoverage() abort
  let l:cwd = getcwd()
  let l:current_file = expand('%')
  let l:coverage_root = l:cwd . '/htmlcov/'
  let l:coverage_file = substitute(l:current_file, '/', '_', '')
  let l:coverage_file = substitute(l:coverage_file, '.py', '.html', '')
  let l:coverage_file = l:coverage_root . l:coverage_file
  let l:coverage_index = l:coverage_root . 'index.html'
  if filereadable(l:coverage_file)
    call system('firefox '.l:coverage_file)
  else
    call system('firefox '.l:coverage_index)
  endif
endfunction

function! RunCoverage() abort
  if exists("*SendToTmux")
    call SendToTmux('coverage run manage.py test')
    call ExecuteKeys('')
  endif
endfunction

function! CoverageReport() abort
  if exists("*SendToTmux")
    call SendToTmux('coverage report')
    call ExecuteKeys('')
  endif
endfunction

function! CoverageHtml() abort
  if exists("*SendToTmux")
    call SendToTmux('coverage html')
    call ExecuteKeys('')
  endif
endfunction

function! WinOneWidth(width) abort
  exe "normal 99\<c-w>l"
  let l:last_window = winnr()
  exe "normal 99\<c-w>h"
  while winnr() != l:last_window
    exe "vert res" a:width
    exe "normal \<c-w>l"
  endwhile
endfunction

let g:nicwest_smartsplit_width = 80
function! s:smartsplit() abort
  if winnr() <= 2
    execute "norm! \<C-W>v\<C-W>l"
  else
    execute "norm! \<C-W>s\<C-W>j"
  endif
endfunction

noremap <F5> :call JavaInsertImport()<CR>
function! JavaInsertImport()
  exe "normal mz"
  let cur_class = expand("<cword>")
  try
    if search('^\s*import\s.*\.' . cur_class . '\s*;') > 0
      throw getline('.') . ": import already exist!"
    endif
    wincmd }
    wincmd P
    1
    if search('^\s*public.*\s\%(class\|interface\)\s\+' . cur_class) > 0
      1
      if search('^\s*package\s') > 0
        yank y
      else
        throw "Package definition not found!"
      endif
    else
      throw cur_class . ": class not found!"
    endif
    wincmd p
    normal! G
    " insert after last import or in first line
    if search('^\s*import\s', 'b') > 0
      put y
    else
      1
      put! y
    endif
    substitute/^\s*package/import/g
    substitute/\s\+/ /g
    exe "normal! 2ER." . cur_class . ";\<Esc>lD"
  catch /.*/
    echoerr v:exception
  finally
    " wipe preview window (from buffer list)
    silent! wincmd P
    if &previewwindow
      bwipeout
    endif
    exe "normal! `z"
  endtry
endfunction

function! s:desnake() abort
  let l:original = @k
  norm! "kyiw
  let l:word = @k
  let l:word = substitute(l:word, '_pc_', '_percentage_', 'g')
  let l:word = substitute(l:word, '_orig_', '_original_', 'g')
  let @k = substitute(l:word, '\(^\|_\)\([a-z]\)', '\u\2', 'g')
  norm! viw"kp
  let @k = l:original
endfunction

function! s:toggle_header_file(split) abort
  let l:current = expand("%:e")
  if l:current == 'm' || l:current == 'c' || l:current == 'cpp'
    let l:target = expand("%:r") . ".h"
  else
    let l:base = expand("%:r")
    if filereadable(l:base . ".c")
      let l:target = l:base . ".c"
    elseif filereadable(l:base . ".cpp")
      let l:target = l:base . ".cpp"
    elseif filereadable(l:base . ".m")
      let l:target = l:base . ".m"
    else
      echoerr "NOOOOOOOOOOOOOOOOPE!!!!!!!!!"
    endif
  endif
  if !a:split
    execute "keepalt keepjumps edit " . l:target
  else
    execute "keepalt keepjumps vsplit " . l:target
  endif
endfunction

" }}}
" Commands: {{{
command! ModeLine :call AppendModeline()
command! SmartSplit :call <SID>smartsplit()
command! DeSnake :call  <SID>desnake()
" }}}
" Leader {{{

" map leader to space
let mapleader = "\<Space>"

" clears search
nnoremap <leader><BS> :noh<cr>

" CTRL-P
nnoremap <Leader>ff :CtrlPBookmarkDir<Cr>

" So Wonely....
nnoremap <leader>1 :only<CR>

" write files
nnoremap <Leader>w :w<CR>
nnoremap <silent><Leader>qw :w<CR>:bw<CR>
nnoremap <silent><Leader>qq :bw!<CR>

" buffer swap
nnoremap <leader><Tab> <C-^>

" reselect pasted text
nnoremap <leader>v V`]

" put under/over
nnoremap <silent> <leader>pu :pu<CR>`[=`]
nnoremap <silent> <leader>po :pu!<CR>`[=`]

" put from the 0 buffer
nnoremap <leader>pp "0p
vnoremap <leader>pp "0p

" open ~/.vimrc in split
nnoremap <leader>ev :SmartSplit<CR>:e $MYVIMRC<CR>
nnoremap <leader>er :source $MYVIMRC<CR>
nnoremap <leader>es :exe ":source" expand("%")<CR>

" open vertical split
nnoremap <leader>S :SmartSplit<CR>
nnoremap <leader>8 :vertical resize 80<CR>
nnoremap <leader>9 :vertical resize 90<CR>
nnoremap <leader>0 :vertical resize 100<CR>

" folding and things
nnoremap <leader><leader> za

" FUGUTIVE
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>go :Gbrowse<CR>
nnoremap <leader>go :Gbrowse<CR>
nnoremap <leader>gp :Gpush
nnoremap <leader>gq :Gpull
nnoremap <leader>gm :Gmerge
nnoremap <leader>gf :call Flake8()<CR>

" scratch binds
nnoremap <leader>n :Scratch<CR>

" quick fix
nnoremap <silent> <leader>qo :copen<CR>
nnoremap <silent> <leader>qO :cclose<CR>
nnoremap <silent> <leader>qc :cex []<CR>

" AG: find things to fix/todo
nnoremap <leader>tf :Ag \(TODO\\|FIXME\)<CR>

"RAINBOW_PARENTHESIS: toggle
nnoremap <leader>(( :RainbowToggle<CR>

"spelling stuff
map <leader>so :setlocal spell!<cr>
map <leader>sa zg
map <leader>ss z=
map <leader>sg 1z=

"toggle tabspaces
nnoremap <leader>tt :set tabstop=2 shiftwidth=2 softtabstop=2<cr>
nnoremap <leader>t<space> :set tabstop=4 shiftwidth=4 softtabstop=4<cr>

"format binds
nnoremap <Leader>dj :set ft=python.django<CR>
nnoremap <Leader>py :set ft=python<CR>
nnoremap <Leader>fd :set ft=txt<CR>
nnoremap <Leader>fm :set ft=markdown<CR>

" Function binds {{{
nnoremap <Leader>ll  :call NumberToggle()<cr>
nnoremap <Leader>jo  :call WrapToggle()<cr>
nnoremap <Leader>zz :call ScrollOffToggle()<CR>
"nnoremap <leader>tl :call DjangoTestThis()<CR>
nnoremap <leader>tl :call PyTestThis()<CR>
nnoremap <leader>co :sil! call OpenCoverage()<CR>
nnoremap <leader>RR :call RunCoverage()<CR>
nnoremap <leader>rr :call CoverageReport()<CR>
nnoremap <leader>ch :call CoverageHtml()<CR>
nnoremap <leader>+ :call WinOneWidth(80)<CR>
nnoremap <leader>= :call WinOneWidth(90)<CR>
" }}}
" }}}
" Key binds {{{

"tab toggles between parenthesis 
nnoremap <tab> %
vnoremap <tab> %

"reselect indented block
vnoremap < <V`]
vnoremap > >V`]

"Y behaves as expected, in accord with C, D etc. 
nnoremap Y y$

"" CTRL-P
"nnoremap <C-p> :CtrlP<CR>
"nnoremap <C-f> :CtrlPBuffer<CR>

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" maps x to null buffer
nnoremap x "_x
xnoremap x "_x

" the only real place that I use the reg for x
nnoremap cx xp 

" because ZZ and ZQ are on the wrong place on this keyboard
nnoremap <bar>Q ZQ
nnoremap <bar><bar> ZZ

"move around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"buffer paging
nnoremap <silent><c-p> :BNext<CR>
nnoremap <silent><c-q> :Bnext<CR>
nnoremap <silent><c-f> :BNext!<CR>
"nnoremap <silent><c-p> :ArrowNext<CR>
"nnoremap <silent><c-f> :ArrowPrevious<CR>
"nnoremap <silent><c-s><c-p> :ArrowSplitNext<CR>
"nnoremap <silent><c-s><c-f> :ArrowSplitPrevious<CR>
"nnoremap <silent><c-q> :ArrowModified<CR>
"nnoremap <silent><c-s>q :ArrowSplitModified<CR>
"nnoremap <silent><c-s>p :ArrowRewind<CR>
"nnoremap <silent><c-s>r :ArrowSplitRewind<CR>
"nnoremap <silent><c-s>f :ArrowLast<CR>
"nnoremap <silent><c-s>l :ArrowSplitLast<CR>
nnoremap <silent><c-s><space> :vert ball 3<CR>
nnoremap <silent><c-s><CR> :vert ball<CR>

nnoremap <c-b> :buffers<CR>:b 

" This feels more logical and I have c-d and c-u for navigation
noremap L $
noremap H ^
noremap $ L
noremap ^ H

"nnoremap j gj
"nnoremap k gk

"opposite of J
"nnoremap K a<CR><ESC>k$

nnoremap <silent> <leader>h :call <SID>toggle_header_file(0)<CR>
nnoremap <silent> <leader>H :call <SID>toggle_header_file(1)<CR>

"NERDTREE: :D
"nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-N> :call system('say -v "Bad News" "Nerd tree is dead, long live file beagle!" &')<CR>

" Projectionist:
nnoremap ga :A<CR>
nnoremap gA :SmartSplit<CR>:A<CR>

nnoremap gs :Estyles<CR>
nnoremap gS :SmartSplit<CR>:Estyles<CR>

nnoremap gp :Eproject<CR>
nnoremap gP :SmartSplit<CR>:Eproject<CR>

" TagBar:
nnoremap <C-T> :TagbarToggle<CR>

" }}}
" Plugin Settings {{{
" Syntastic {{{
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225,E226,E265'
let g:syntastic_java_javac_classpath = "/home/nic/learn/android/MyFirstApp/bin/classes:/home/nic/android/platforms/android-23/*.jar"
" }}}
" CTRL-P {{{
let g:ctrlp_extensions = ['funky']

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
if executable('ag')
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
endif
" }}}
" Ag {{{
" Use Ag over Grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
" }}}
" Flake8: {{{
let g:flake8_max_markers = 0

" }}}
" NERDTree {{{
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeQuitOnOpen = 1
" }}}
" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
" }}}
" YouCompleteMe {{{
let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_python_interpreter = "/usr/bin/python"
"let 
" }}}
" TSlime {{{
nmap <C-c><C-c> <Plug>ExecuteKeysCc
nmap <C-c><C-x> <Plug>ExecuteKeysCl
nmap <C-c>r <Plug>SetTmuxVars
" }}}
" Targets {{{
"let g:targets_separators = ', . ; : + - = ~ _ * # / | \ & $'
"}}}
" Endwise: {{{
let g:endwise_abbreviations = 1
" }}}
" Rainbow: {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
      \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \   'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta'],
      \   'operators': '_,_',
      \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \   'separately': {
      \       '*': {},
      \       'tex': {
      \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
      \       },
      \       'lisp': {
      \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
      \       },
      \       'html': {
      \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
      \       },
      \       'htmldjango': 0,
      \       'css': 0,
      \   }
      \}
" }}}
" Filebeagle: {{{
let g:filebeagle_check_gitignore = 1
" }}}
" Go: {{{
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>tl <Plug>(go-test)
au FileType go nmap <leader>RR <Plug>(go-coverage)
au FileType go nmap <Leader>re <Plug>(go-rename)
au FileType go nmap <Leader>I <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
" }}}
" Workman: {{{
"let g:workman_normal_qwerty = 1

" }}}
"" }}}
" Mouse {{{

" scrollwheel speed 
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>

" }}}
" Autocommands {{{
autocmd FileType python source ~/.vim/plugged/jpythonfold.vim/syntax/jpythonfold.vim

"use spellchecking when writing md
au BufRead *.md setlocal spell spelllang=en_gb
au BufRead *.markdown setlocal spell spelllang=en_gb

"set tab stops based on file type
autocmd Filetype html,htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype css,scss setlocal ts=2 sts=2 sw=2
autocmd Filetype vim setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml,yml setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

"markdown :D
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd Filetype markdown setlocal tw=80
autocmd Filetype markdown setlocal wm=4
"autocmd Filetype markdown setlocal fo=cat 
"
autocmd Filetype notes RainbowToggle

"clojure/vim
autocmd BufNewFile,BufRead *.cljx set ft=clojure
"autocmd BufNewFile,BufRead *.clj,*.cljs,*.vim RainbowParenthesesActivate
"autocmd BufNewFile,BufRead *.clj,*.cljs,*.vim RainbowParenthesesLoadRound
"autocmd BufNewFile,BufRead *.clj,*.cljs,*.vim RainbowParenthesesLoadSquare
"autocmd BufNewFile,BufRead *.clj,*.cljs,*.vim RainbowParenthesesLoadBraces

"help
autocmd Filetype vim nnoremap ? :vert help 
autocmd Filetype qf setlocal nowrap nonumber norelativenumber colorcolumn=

"Scriptease
autocmd Filetype vim nnoremap \| :Runtime<CR>

"bind test commands
autocmd Filetype vim nnoremap <leader>tl :call ThemisTestThis()<CR>
"autocmd Filetype python nnoremap <leader>tl :call DjangoTestThis()<CR>
autocmd Filetype python nnoremap <leader>tl :call PyTestThis()<CR>

autocmd User FileBeagleReadPost nnoremap <buffer> . PreFill! !

" }}}
" Misc {{{

" Make backup folders etc automatically if they don't already exist.
if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
   call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
   call mkdir(expand(&directory), "p")
endif

"auto set clipboard
set clipboard=unnamed

"}}}
noh
"vim: set ft=vim ts=2 sw=2 tw=78 et :
