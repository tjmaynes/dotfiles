" ---- dot vimrc ----
" Author: TJ Maynes <tj at tjmaynes dot com>
" Website: https://tjmaynes.com/


" Default Configuration

set nocompatible                    "work with old systems
set encoding=utf-8                  "utf-8, please

set lazyredraw                      "no lag, please
set ttyfast
set synmaxcol=300

set backspace=indent,eol,start      "unix solution
set showmatch
set showcmd                         "shows what commands are available
set hlsearch                        "highlight search results
set incsearch                       "incremental search
set novisualbell                    "no yellin'

set linespace=0
set history=100                     "histoy of old commands run
set antialias
set autowrite                       "write before running commands
set autochdir                       "start vim in current directory
set hidden
set autoread

set nonumber
set modeline
set wildmenu
set wildmode=longest,list,full
set completeopt+=longest
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,node_modules,Carthage,_site,vendor,*.pyc,venv
set omnifunc=syntaxcomplete#Complete

silent execute '!mkdir -p ~/.vim/tmp'
set directory=~/.vim/tmp            " don't litter my drive with .swp files

silent execute '!mkdir -p ~/.vim/backup'
set backupdir=~/.vim/backup         " put backup files in .vim directory


set foldmethod=indent
set foldlevel=99

set background=dark
silent! syntax enable

filetype indent on

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  set transparency=3
  set guifont=InconsolataGo:h16
  set guioptions-=L
  set guioptions-=r
endif

nnoremap <C-n> :bnext<cr>
nnoremap <C-p> :bprevious<cr>
nnoremap <space> za
nmap <silent> <leader>w :w!<cr>
nmap <silent> <leader>. :tabnext<cr>
nmap <silent> <leader>/ :tabnext<cr>
nmap <silent> <leader>q :r! date +"\%Y-\%m-\%d \%H:\%M:\%S"<cr>

"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
