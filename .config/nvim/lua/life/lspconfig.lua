-- VARIABLES
local lspconfig = require 'lspconfig'
local lspkind = require('lspkind')

-- CMP CONFIG
local cmp = require 'cmp'
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    })
  },
  -- REQUIRED - you must specify a snippet engine
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item()
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'path' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())



-- LSP CONFIG
-- AU CMDlspconf
local metals_config = require("metals").bare_config()
metals_config.capabilities = capabilities

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.clangd.setup {
  capabilities = capabilities
}
lspconfig.pylsp.setup {
  capabilities = capabilities
}

local null_ls = require 'null-ls'
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
    async = false,
  })
end
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }), -- eslint or eslint_d
    null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
    null_ls.builtins.formatting.eslint_d, -- prettier, eslint, eslint_d, or prettierd
    null_ls.builtins.formatting.prettierd.with({
      -- disabled_filetypes = {"yaml"},
      condition = function(utils)
        return not utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    null_ls.builtins.diagnostics.vale,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})

-- require("typescript").setup({
--   disable_commands = false, -- prevent the plugin from creating Vim commands
--   disable_formatting = true, -- disable tsserver's formatting capabilities
--   debug = false, -- enable debug logging for commands
--   settings = {
--     javascript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--     typescript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--   }
-- })
--
lspconfig.ts_ls.setup {
  capabilities = capabilities
}

lspconfig.gopls.setup {
  capabilities = capabilities
}
lspconfig.vimls.setup {
  capabilities = capabilities
}
lspconfig.texlab.setup {
  capabilities = capabilities,
  settings = {
    latex = {
      build = {
        args = { "-pdf", "-pvc", "-interaction=nonstopmode", "-synctex=1", "%f" },
      },
      forwardSearch = {
        args = { "--synctex-forward", "%l:1:%f", "%p" },
        executable = "zathura",
        onSave = false
      }
    }
  }
}
lspconfig.dockerls.setup {
  capabilities = capabilities,
}
lspconfig.cssls.setup {
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}
lspconfig.sqlls.setup {
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" }
}
lspconfig.r_language_server.setup {
  capabilities = capabilities,
}
lspconfig.hls.setup {}

lspconfig.astro.setup {}

-- lspconfig.rnix.setup {}
lspconfig.nil_ls.setup {}

require('inlay-hints').setup()
