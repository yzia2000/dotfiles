syntax on

set exrc
set nopreviewwindow
set laststatus=0
set nohlsearch
set nopaste
set noerrorbells
set hidden
set nobackup
set noswapfile
set undodir=~/.undodir
set undofile
set noruler
set noshowcmd
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2 softtabstop=2
set incsearch
set expandtab
set nowrap
set colorcolumn=80
set nofoldenable
set updatetime=50
set shortmess+=c
set noshowmode
set completeopt=menu,menuone,noselect
set signcolumn=yes

let mapleader = " "

source $HOME/.config/nvim/plugins.vim

set termguicolors
let g:gruvbox_italic=1
colo ayu

source $HOME/.config/nvim/au.vim
source $HOME/.config/nvim/var.vim
source $HOME/.config/nvim/mappings.vim

lua require'init'
