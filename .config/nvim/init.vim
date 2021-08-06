set background=dark
set cmdheight=2
set colorcolumn=100
set completeopt=menuone,noinsert,noselect
set expandtab
set hidden
set ignorecase
set incsearch
set nobackup
set noerrorbells
set nohlsearch
set noshowmode
set noswapfile
set nowrap
set scrolloff=8
set shiftwidth=2
set shortmess+=c
set signcolumn=yes
set smartcase
set smartindent
set tabstop=2 softtabstop=2
set termguicolors
set undodir=~/.cache/neovim/undodir
set undofile
set updatetime=50

syntax enable
filetype plugin indent on

lua << EOF
EOF

nnoremap <silent> k gk
nnoremap <silent> j gj
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> 0 g0
nnoremap <silent> $ g$
nnoremap <silent> <Down> gj
nnoremap <silent> <Up> gk
vnoremap <silent> <Down> gj
vnoremap <silent> <Up> gk
inoremap <silent> <Down> <C-o>gj
inoremap <silent> <Up> <C-o>gk

nnoremap <silent> n nzz
nnoremap <silent> b bzz

nnoremap <silent> . <NOP>

let mapleader = " "
nnoremap <silent> <leader>wh :wincmd h<cr>
nnoremap <silent> <leader>wj :wincmd j<cr>
nnoremap <silent> <leader>wk :wincmd k<cr>
nnoremap <silent> <leader>wl :wincmd l<cr>
nnoremap <silent> <leader>wv :wincmd v<cr>
nnoremap <silent> <leader>ws :wincmd s<cr>
nnoremap <silent> <leader>wd :q<cr>

nnoremap <A-a> :terminal<cr>i
nnoremap <A-m> :terminal ncmpcpp<cr>i
nnoremap <A-p> :terminal htop<cr>i
nnoremap <A-n> :terminal newsboat<cr>i
nnoremap <A-s> :terminal pulsemixer<cr>i

tnoremap <A-Esc> <C-\><C-n>
tnoremap <A-q> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bp :bprev<cr>
nnoremap <silent> <leader>bd :bdelete<cr>
