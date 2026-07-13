-- nvim-treesitter `main` branch (the rewrite). The old module system
-- (highlight / indent / incremental_selection / rainbow via configs.setup) is
-- gone. We: set the install dir, keep a base set of parsers installed, and
-- enable highlighting per-buffer through a FileType autocmd.

require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

-- Parsers to keep installed. Idempotent and async — installs/updates missing
-- ones in the background (needs the tree-sitter CLI + a C compiler on PATH).
require('nvim-treesitter').install {
  'bash', 'bibtex', 'c', 'cpp', 'css', 'go', 'haskell', 'html',
  'java', 'javascript', 'json', 'latex', 'lua', 'markdown',
  'markdown_inline', 'python', 'query', 'rust', 'scala', 'toml',
  'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
}

-- Enable treesitter highlighting for any buffer whose filetype has a parser.
-- pcall guards filetypes without an installed parser.
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
