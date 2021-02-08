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

lspconfig.clangd.setup{}
lspconfig.pyls.setup{}
lspconfig.tsserver.setup{}
lspconfig.gopls.setup{}
lspconfig.vimls.setup{}
lspconfig.texlab.setup{
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
lspconfig.sumneko_lua.setup{
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim', 'spoon', 'hs'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}
lspconfig.dockerls.setup{}
lspconfig.cssls.setup{}
