nnoremap <C-h> :cp<CR>
nnoremap <C-l> :cn<CR>
nnoremap <C-s> :cclose<CR>
nnoremap <leader>rnu :set number rnu<CR>
nnoremap <leader>run :set nonumber norelativenumber<CR>
nnoremap <leader>rc :e $MYVIMRC<CR>
nnoremap <leader>cd :cd %:p:h<CR>

nnoremap <leader>dr :lua require'dap'.repl.toggle()<CR>
nnoremap <leader>bre :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>b<space> :lua require'dap'.continue()<CR>
nnoremap <leader>bl :lua require'dap'.step_into()<CR>
nnoremap <leader>bj :lua require'dap'.step_over()<CR>
nnoremap <leader>bva :lua require'dap.ui.variables'.hover()<CR>
vnoremap <leader>bva :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>bvs :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>bvm :lua require'dap.ui.variables'.toggle_multiline_display()<CR>

nnoremap <leader>ind :IndentLinesToggle<CR>

nmap <C-q> <Plug>BujoAddnormal
imap <C-q> <Plug>BujoAddinsert
nmap <C-s> <Plug>BujoChecknormal
imap <C-s> <Plug>BujoCheckinsert

nnoremap <A-a> :FloatermToggle first<CR>
nnoremap <A-;> :FloatermToggle second<CR>
nnoremap <leader>teu :lua require('ntty.term').gotoTerminal(1)<CR>
nnoremap <leader>tei :lua require('ntty.term').gotoTerminal(2)<CR>
nnoremap <leader>teo :lua require('ntty.term').gotoTerminal(11)<CR>
nnoremap <leader>tei :lua require('ntty.term').gotoTerminal(12)<CR>
nnoremap <leader>teh :lua require('ntty.term').switch_back()<CR>
nnoremap <leader>icu :lua require('ntty.term').sendCommand(3, true)<CR>
nnoremap <leader>ici :lua require('ntty.term').sendCommand(4, true)<CR>
nnoremap <leader>ico :lua require('ntty.term').sendCommand(5, true)<CR>
nnoremap <leader>icp :lua require('ntty.term').sendCommand(6, true)<CR>
nnoremap <leader>ncu :lua require('ntty.term').sendCommand(3, false)<CR>
nnoremap <leader>nci :lua require('ntty.term').sendCommand(4, false)<CR>
nnoremap <leader>nco :lua require('ntty.term').sendCommand(5, false)<CR>
nnoremap <leader>ncp :lua require('ntty.term').sendCommand(6, false)<CR>
nnoremap <leader>ccu :lua require('ntty.term').sendPreviousCommand(3)<CR>
nnoremap <leader>cci :lua require('ntty.term').sendPreviousCommand(4)<CR>
nnoremap <leader>cco :lua require('ntty.term').sendPreviousCommand(5)<CR>
nnoremap <leader>ccp :lua require('ntty.term').sendPreviousCommand(6)<CR>
nnoremap <leader>tcu :lua require('ntty.term').gotoTerminal(3)<CR>
nnoremap <leader>tci :lua require('ntty.term').gotoTerminal(4)<CR>
nnoremap <leader>tco :lua require('ntty.term').gotoTerminal(5)<CR>
nnoremap <leader>tcp :lua require('ntty.term').gotoTerminal(6)<CR>
nnoremap <leader>ren :lua require('ntty.term').renameFile()<left>

tnoremap <A-a> <cmd>FloatermToggle first<CR>
tnoremap <A-;> <cmd>FloatermToggle second<CR>

" tnoremap <A-b> <cmd>FloatermToggle<CR>
tnoremap `` <C-\><C-n><CR> 

nnoremap <leader>vd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd <cmd>lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>vdd <cmd>Telescope lsp_document_diagnostics<CR>
nnoremap <leader>vwd <cmd>Telescope lsp_workspace_diagnostics<CR>
nnoremap <leader>vfm <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>vss <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <leader>vsw <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dtcb :call vimspector#ClearBreakpoints()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <leader>dst :VimspectorReset<CR>
nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dvv <Plug>VimspectorBalloonEval

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
vnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>ph :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>vmf :lua require('life.telescope').search_dotfiles()<CR>

nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>p "_dP
nnoremap <leader>pc "+P
vnoremap <leader>pc "+P

nnoremap <leader>Y gg"+yG
inoremap <C-c> <esc>
vnoremap . :normal .<CR>

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

nnoremap <leader>mx :MaximizerToggle<CR>

au FileType java nnoremap <buffer><leader>vca <Cmd>lua require('jdtls').code_action()<CR>
au FileType java vnoremap <buffer><leader>vca <Cmd>lua require('jdtls').code_action(true)<CR>
au FileType java nnoremap <buffer><leader>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
au FileType java nnoremap <buffer><leader>voo <Cmd>lua require'jdtls'.organize_imports()<CR>
au FileType java nnoremap <buffer><leader>crv <Cmd>lua require('jdtls').extract_variable()<CR>
au FileType java vnoremap <buffer><leader>crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
au FileType java nnoremap <buffer><leader>crc <Cmd>lua require('jdtls').extract_constant()<CR>
au FileType java vnoremap <buffer><leader>crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
au FileType java vnoremap <buffer><leader>crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
au FileType java nnoremap <buffer><leader>df <Cmd>lua require'jdtls'.test_class()<CR>
au FileType java nnoremap <buffer><leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
