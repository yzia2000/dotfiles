local lspconfig = require'lspconfig'
lspconfig.clangd.setup{}
lspconfig.pyls.setup{}
lspconfig.tsserver.setup{}
lspconfig.gopls.setup{}
lspconfig.vimls.setup{}
lspconfig.texlab.setup{
  settings = {
    latex = {
      build = {
        args = {"-pdf", "-pvc", "-interaction=nonstopmode", "-synctex=1", "%f"};
        onSave = true;
      };
      forwardSearch = {
        args = {"--synctex-forward", "%l:1:%f", "%p"};
        executable = "zathura";
        onSave = true;
      };
    }
  }
}
lspconfig.dockerls.setup{}
