-- VARIABLES
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local lspconfig = require'lspconfig'
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- CMP CONFIG
local cmp = require'cmp'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
  }
})



-- LSP CONFIG
lspconfig.sumneko_lua.setup{
  cmd = {"lua-language-server"},
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        globals = {'vim', 'spoon', 'hs'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.clangd.setup{
  capabilities = capabilities
}
lspconfig.pylsp.setup{
  capabilities = capabilities
}

local null_ls = require'null-ls'
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
    null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
    null_ls.builtins.formatting.eslint_d -- prettier, eslint, eslint_d, or prettierd
  },
})

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},

      -- inlay hints
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
  end
}

lspconfig.gopls.setup{
  capabilities = capabilities
}
lspconfig.vimls.setup{
  capabilities = capabilities
}
lspconfig.texlab.setup{
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
lspconfig.dockerls.setup{
  capabilities = capabilities,
}
lspconfig.cssls.setup{
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
}
lspconfig.sqlls.setup{
  capabilities = capabilities,
  cmd = {"sql-language-server", "up", "--method", "stdio"}
}
lspconfig.r_language_server.setup{
  capabilities = capabilities,
}
lspconfig.hls.setup{}
