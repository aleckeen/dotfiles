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
let &undodir = join([stdpath("cache"), "undo"], "/")
set undofile
set updatetime=50

syntax enable
filetype plugin indent on

lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn

local packer_repo = "https://github.com/wbthomason/packer.nvim"
local packer = fn.join({fn.stdpath("data"), "site", "pack", "packer", "start", "packer.nvim"}, "/")

if fn.empty(fn.glob(packer)) > 0 then
  execute "echo 'Downloading `packer.nvim`.'"
  fn.system({"git", "clone", packer_repo, packer})
  execute "packadd packer.nvim"
end

vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.startup(function(use)
  use { "wbthomason/packer.nvim" }

  -- Visual
  use {
    "ayu-theme/ayu-vim",
    config = function()
      vim.g.ayucolor = "mirage"
      vim.cmd [[colorscheme ayu]]
      vim.cmd [[hi Normal guibg=none]]
    end,
  }
  use {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = 'horizon',
          component_separators = {'', ''},
          section_separators = {'', ''},
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end,
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
  }
end)

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
nnoremap <silent> <leader>wd :wincmd q<cr>

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
