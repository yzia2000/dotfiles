vim.cmd([[ syntax on ]])

vim.cmd([[ set exrc ]])
vim.cmd([[ set nopreviewwindow ]])
vim.cmd([[ set nohlsearch ]])
vim.cmd([[ set nopaste ]])
vim.cmd([[ set noerrorbells ]])
vim.cmd([[ set hidden ]])
vim.cmd([[ set backup ]])
vim.cmd([[ set backupdir=~/.backupdir// ]])
vim.cmd([[ set swapfile ]])
vim.cmd([[ set undofile ]])
vim.cmd([[ set undodir=~/.undodir ]])
vim.cmd([[ set noruler ]])
vim.cmd([[ set noshowcmd ]])
vim.cmd([[ set autoindent ]])
vim.cmd([[ set smartindent ]])
vim.cmd([[ set shiftwidth=2 ]])
vim.cmd([[ set tabstop=2 softtabstop=2 ]])
vim.cmd([[ set incsearch ]])
vim.cmd([[ set expandtab ]])
vim.cmd([[ set nowrap ]])
vim.cmd([[ set colorcolumn=110 ]])
vim.cmd([[ set nofoldenable ]])
vim.cmd([[ set updatetime=50 ]])
vim.cmd([[ set shortmess+=c ]])
vim.cmd([[ set noshowmode ]])
vim.cmd([[ set completeopt=menu,menuone,noselect ]])
vim.cmd([[ set signcolumn=yes ]])
vim.cmd([[ set rnu ]])
vim.cmd([[ set number ]])
vim.cmd([[ set termguicolors ]])
vim.cmd([[ set laststatus=3 ]])
vim.cmd([[ set winbar=%f ]])
vim.cmd([[ set clipboard=unnamedplus ]])
vim.cmd([[ set scrolloff=15 ]])

vim.cmd([[ let mapleader = " " ]])

vim.cmd([[ let g:did_load_filetypes = 1 ]])

vim.cmd([[ set termguicolors ]])

-- vim.cmd([[ let g:gruvbox_italic=1 ]])
-- vim.cmd([[ colo duskfox ]])
vim.cmd([[ colo tokyonight-night ]])

vim.cmd([[ source $HOME/.config/nvim/au.vim ]])
vim.cmd([[ source $HOME/.config/nvim/var.vim ]])
vim.cmd([[ source $HOME/.config/nvim/mappings.vim ]])

require('impatient')
require 'plugins'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

require('fidget').setup{}
-- require('feline').setup()
require('lualine').setup{}
require('gitsigns').setup()

require 'life.lspconfig'
require 'life.telescope'
require 'life.treesitter'
require 'life.dap'
require 'mappings'
