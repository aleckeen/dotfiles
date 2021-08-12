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
set updatetime=300

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

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    after = { "completion-nvim", "nvim-lspinstall" },
    config = function()
      local lsp = require("lspconfig")
      local on_attach = function(client)
        require("completion").on_attach(client)
      end

      -- Enable lsp servers
      local function setup_servers()
        require("lspinstall").setup()
        local servers = require("lspinstall").installed_servers()
        for _, server in pairs(servers) do
          require("lspconfig")[server].setup({ on_attach=on_attach })
        end
      end

      setup_servers()

      require("lspinstall").post_install_hook = function()
        setup_servers()
        vim.cmd [[bufdo e]]
      end

      -- Enable diagnostics
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          signs = true,
          update_in_insert = true,
        }
      )
    end,
  }
  use { "nvim-lua/lsp_extensions.nvim" }
  use { "nvim-lua/completion-nvim" }
  use {
    "simrat39/rust-tools.nvim",
    after = "nvim-lspconfig",
    config = function() require("rust-tools").setup({}) end
  }
  use { "kabouzeid/nvim-lspinstall" }
  use { "udalov/kotlin-vim" }

  -- Tools
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
end)

EOF

let mapleader = " "

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

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
nnoremap <silent> N Nzz

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

nnoremap <silent> . <NOP>

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
