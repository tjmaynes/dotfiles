" ---- dot vimrc ----
" Author: TJ Maynes <tjmaynes at gmail dot com>
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

set number
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
set laststatus=2                    "always show status line
set modeline
set wildmenu
set wildmode=longest,list,full
set completeopt+=longest
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,node_modules,Carthage,_site,vendor,*.pyc,venv
set omnifunc=syntaxcomplete#Complete

set directory=~/.vim/tmp            " don't litter my drive with .swp files
set backupdir=~/.vim/backup         " put backup files in .vim directory
silent execute '!mkdir -p ~/.vim/tmp'
silent execute '!mkdir -p ~/.vim/backup'

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set foldmethod=indent
set foldlevel=99

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  set transparency=3
  set guifont=Inconsolata_For_Powerline:h16
  set guioptions-=L
  set guioptions-=r
endif

nnoremap <C-n> :bnext<cr>
nnoremap <C-p> :previous<cr>
nmap <silent> <leader>w :w!<cr>
nmap <silent> <leader>. :tabnext<cr>
nmap <silent> <leader>/ :tabnext<cr>
nmap <silent> <leader>q :r! date +"\%Y-\%m-\%d \%H:\%M:\%S"<cr>

"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"folding
nnoremap <space> za


" Packages

call plug#begin('~/.vim/plugged')

Plug 'jnurmine/Zenburn'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jamessan/vim-gnupg'
Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'vim-scripts/fountain.vim'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'

Plug 'vim-python/python-syntax'
Plug 'fatih/vim-go'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'isRuslan/vim-es6'

Plug 'ekalinin/Dockerfile.vim'

call plug#end()


" Development

set background=dark
colorscheme zenburn

filetype indent on
syntax enable


" Language support

autocmd BufNewFile,BufRead .babelrc setf json
autocmd BufNewFile,BufRead *.fountain set filetype=fountain

autocmd FileType make
      \ set noexpandtab

autocmd BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

autocmd BufNewFile,BufRead *.js, *.html, *.css
      \ set tabstop=2 |
      \ set softtabstop=2 |
      \ set shiftwidth=2

let g:jsx_ext_required = 0

" Goyo support

map <silent> <leader>g :Goyo<cr>

" NERDTree support

let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeQuitOnOpen=0
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1

map <silent> <leader>d :execute 'NERDTreeToggle ' . getcwd()<cr>
map <silent> <leader>b :NERDTreeFromBookmark<cr>

" Pretty JSON

command PyJSONPretty execute "%!python -m json.tool"
nnoremap <leader>j :PyJSONPretty<cr>

" Syntastic support

let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": [], "passive_filetypes": ["python"]}

map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
