return {
  -- Packer can manage itself
  'wbthomason/packer.nvim',

  'gyim/vim-boxdraw',

  'sbdchd/neoformat',

  -- use 'tpope/vim-commentary'
  {
    'numToStr/Comment.nvim', opts = {}
  },

  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-dispatch',
  'tpope/vim-dadbod',
  'tpope/vim-markdown',
  'tpope/vim-eunuch',
  'lambdalisue/suda.vim',

  'voldikss/vim-floaterm',

  'neovim/nvim-lspconfig',
  'tjdevries/nlua.nvim',
  'tjdevries/lsp_extensions.nvim',

  'norcalli/nvim-colorizer.lua',

  'ianding1/leetcode.vim',
  'vim-utils/vim-man',
  'rafi/awesome-vim-colorschemes',
  'Yggdroot/indentLine',
  'mbbill/undotree',
  'SirVer/ultisnips',
  'vuciv/vim-bujo',
  'honza/vim-snippets',

  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-fzy-native.nvim',
  'nvim-telescope/telescope-dap.nvim',

  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
  },

  'dstein64/vim-startuptime',

  'mfussenegger/nvim-dap',

  'puremourning/vimspector',

  'bounceme/remote-viewer',

  'tami5/sql.nvim',
  'prettier/vim-prettier',

  'nvim-tree/nvim-web-devicons',

  'nvim-tree/nvim-tree.lua',

  'mfussenegger/nvim-jdtls',

  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp-signature-help',


  -- 'jose-elias-alvarez/null-ls.nvim',

  -- 'jose-elias-alvarez/nvim-lsp-ts-utils',

  'scalameta/nvim-metals',

  "EdenEast/nightfox.nvim",

  -- use "feline-nvim/feline.nvim"
  'nvim-lualine/lualine.nvim',

  "lewis6991/gitsigns.nvim",

  -- 'jose-elias-alvarez/typescript.nvim',

  'ray-x/lsp_signature.nvim',
  'j-hui/fidget.nvim',
  'softinio/scaladex.nvim',
  'simnalamburt/vim-mundo',
  "fladson/vim-kitty",

  'sindrets/diffview.nvim',
  'kevinhwang91/nvim-bqf',
  "onsails/lspkind-nvim",

  "simrat39/inlay-hints.nvim",

  -- Lua
  {
    "folke/lsp-trouble.nvim", opts = {}
  },

  'folke/lsp-colors.nvim',

  'lewis6991/impatient.nvim',

  {
    "glepnir/lspsaga.nvim",
    opts = {},
  },

  { "akinsho/toggleterm.nvim", opts = { size = 100 } },

  { "folke/tokyonight.nvim",   opts = {} },

  {
    "rose-pine/neovim",
    name = "rose-pine",
  },

  -- Flexoki (kepano) — the "Minimal" palette
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    lazy = false,
    priority = 1000,
  },

  -- "github/copilot.vim",

  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = {
  --     -- Recommended for `ask()` and `select()`.
  --     -- Required for `snacks` provider.
  --     ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
  --     { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  --   },
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable the image module to get LaTeX previews
      image = {
        enabled = true,
        doc = {
          -- Set to true to see equations embedded directly in the buffer
          inline = true,
          -- Can display equation previews in a floating window on hover
          float = false,
        },
        -- Render math at higher DPI. The default -density is only 192, which
        -- looks blurry on a HiDPI / fractionally-scaled display. snacks fits the
        -- image down to the inline text height, so more source pixels = sharper,
        -- not bigger. Dial to taste: 384 = lighter, 600 = crisp.
        convert = {
          magick = {
            math = { "-density", 600, "{src}[{page}]", "-trim" },
          },
        },
      },
    },
  },

  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "tmux",
          enabled = true
        }
      }
    },
    keys = {
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
    }
  },

  -- Cursor-style next-edit prediction via local Ollama
  -- <Tab> accepts next hunk, <C-j> accepts line-by-line, <C-]> clears
  -- Requires: ollama pull qwen2.5-coder:7b
  -- {
  --   "BlinkResearchLabs/blink-edit.nvim",
  --   event = "InsertEnter",
  --   opts = {
  --     llm = {
  --       backend = "openai",
  --       provider = "sweep",
  --       url = "http://localhost:8000",
  --       model = "sweep",
  --     },
  --     history = {
  --       enabled = true,
  --     },
  --     debounce_ms = 500,
  --     keymaps = {
  --       insert = {
  --         accept = "<Tab>",
  --         accept_line = "<C-j>",
  --         clear = "<C-]>",
  --         reject = nil,
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "cursortab/cursortab.nvim",
  --   -- version = "*",  -- Use latest tagged version for more stability
  --   lazy = false,   -- The server is already lazy loaded
  --   build = "cd server && go build",
  --   config = function()
  --     require("cursortab").setup({
  --       keymaps = {
  --         accept = "<C-j>",
  --       },
  --       provider = {
  --         -- Mercury API (hosted)
  --         type = "mercuryapi",
  --         api_key_env = "INCEPTION_API_KEY",
  --
  --         -- Zeta-2 (best local)
  --         -- type = "zeta-2",
  --         -- url = "http://localhost:8000",
  --
  --         -- Qwen3.5-0.8B (fastest local, defaults to "inline")
  --         -- url = "http://localhost:8000",
  --
  --         -- sweep-next-edit-0.5B/1.5B (fastest local)
  --         -- type = "sweep",
  --         -- url = "http://localhost:8000",
  --         -- max_tokens = 4096
  --       },
  --     })
  --   end,
  -- },

  'MeanderingProgrammer/render-markdown.nvim',
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-j>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-l>",
        },
      })
    end,
  }
}
