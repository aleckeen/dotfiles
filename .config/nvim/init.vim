set background=dark
set cmdheight=2
set colorcolumn=80
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
local path = require("path")
local pm = require("pm")
local uv = vim.loop

pm.init()

local url = "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-linux"
pm.download_executable(url, "rust-analyzer")

pm.pm { git    = "https://github.com/gruvbox-community/gruvbox.git"
      , as     = "gruvbox"
      , config = function()
          vim.cmd("colorscheme gruvbox")
          vim.cmd("hi Normal guibg=none")
        end }

pm.pm { git = "https://github.com/rust-lang/rust.vim.git"
      , as  = "rust.vim"
      }

pm.pm { git   = "https://github.com/nvim-telescope/telescope.nvim.git"
      , as    = "telescope.nvim"
      , after = { "plenary.nvim", "popup.nvim" }
      }
pm.pm { git   = "https://github.com/nvim-lua/popup.nvim.git"
      , as    = "popup.nvim"
      , after = "plenary.nvim"
      }
pm.pm { git = "https://github.com/nvim-lua/plenary.nvim.git"
      , as  = "plenary.nvim"
      }

pm.pm { git = "https://github.com/nvim-lua/completion-nvim.git"
      , as  = "completion-nvim"
      }
pm.pm { git    = "https://github.com/neovim/nvim-lspconfig.git"
      , as     = "nvim-lspconfig"
      , after  = "completion-nvim"
      , config = function()
          require("rust")
        end
      }
pm.pm { git = "https://github.com/nvim-lua/lsp_extensions.nvim.git"
      , as  = "lsp_extensions.nvim"
      }
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

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

nnoremap <silent> . <NOP>

let mapleader = " "
nnoremap <silent> <leader>wh :wincmd h<cr>
nnoremap <silent> <leader>wj :wincmd j<cr>
nnoremap <silent> <leader>wk :wincmd k<cr>
nnoremap <silent> <leader>wl :wincmd l<cr>
nnoremap <silent> <leader>wv :wincmd v<cr>
nnoremap <silent> <leader>ws :wincmd s<cr>
nnoremap <silent> <leader>wd :q<cr>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>

nnoremap <leader>bb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprev<CR>

nnoremap <leader>ht <cmd>lua require('telescope.builtin').help_tags()<cr>
