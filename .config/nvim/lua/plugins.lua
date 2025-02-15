vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'gyim/vim-boxdraw'

  use 'sbdchd/neoformat'

  -- use 'tpope/vim-commentary'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-dadbod'
  use 'tpope/vim-markdown'
  use 'tpope/vim-eunuch'
  use 'lambdalisue/suda.vim'

  use 'voldikss/vim-floaterm'

  use 'neovim/nvim-lspconfig'
  use 'tjdevries/nlua.nvim'
  use 'tjdevries/lsp_extensions.nvim'

  use 'norcalli/nvim-colorizer.lua'

  use 'ianding1/leetcode.vim'
  use 'vim-utils/vim-man'
  use 'rafi/awesome-vim-colorschemes'
  use 'Yggdroot/indentLine'
  use 'mbbill/undotree'
  use 'SirVer/ultisnips'
  use 'vuciv/vim-bujo'
  use 'honza/vim-snippets'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-dap.nvim'

  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'dstein64/vim-startuptime'

  use 'mfussenegger/nvim-dap'

  use 'puremourning/vimspector'

  use 'bounceme/remote-viewer'

  use 'tami5/sql.nvim'
  use '~/.config/nvim/nvim_plugins/ntty'
  use 'prettier/vim-prettier'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  use 'mfussenegger/nvim-jdtls'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'


  use 'jose-elias-alvarez/null-ls.nvim'

  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  use 'scalameta/nvim-metals'

  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- use 'p00f/nvim-ts-rainbow'

  use "EdenEast/nightfox.nvim"

  -- use "feline-nvim/feline.nvim"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use "lewis6991/gitsigns.nvim"

  use 'jose-elias-alvarez/typescript.nvim'

  use { 'ray-x/lsp_signature.nvim' }
  use { 'j-hui/fidget.nvim', tag = 'legacy' }
  use { 'softinio/scaladex.nvim' }
  use 'simnalamburt/vim-mundo'
  use "fladson/vim-kitty"

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use "onsails/lspkind-nvim"

  use "simrat39/inlay-hints.nvim"

  -- Lua
  use {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'folke/lsp-colors.nvim'

  use 'lewis6991/impatient.nvim'

  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({})
    end,
    requires = { { "nvim-tree/nvim-web-devicons" } }
  })

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup({
      size = 100
    })
  end }

  use "folke/tokyonight.nvim"
end)
