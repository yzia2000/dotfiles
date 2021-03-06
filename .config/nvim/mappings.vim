nnoremap <leader>rnu :set number rnu<CR>
nnoremap <leader>run :set nonumber norelativenumber<CR>
nnoremap <leader>rc :e $MYVIMRC<CR>

nnoremap <leader>bre :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>b<space> :lua require'dap'.continue()<CR>
nnoremap <leader>bl :lua require'dap'.step_into()<CR>

nmap <leader>ind :IndentLinesToggle<CR>

nmap <C-q> <Plug>BujoAddnormal
imap <C-q> <Plug>BujoAddinsert
nmap <C-s> <Plug>BujoChecknormal
imap <C-s> <Plug>BujoCheckinsert

nnoremap <A-1> :FloatermToggle first<CR>
nnoremap <A-2> :FloatermToggle second<CR>
nnoremap <A-3> :FloatermToggle third<CR>
nnoremap <A-4> :FloatermToggle fourth<CR>
nnoremap <A-5> :FloatermToggle five<CR>

tnoremap <A-1> <cmd>FloatermToggle first<CR>
tnoremap <A-2> <cmd>FloatermToggle second<CR>
tnoremap <A-3> <cmd>FloatermToggle third<CR>
tnoremap <A-4> <cmd>FloatermToggle fourth<CR>
tnoremap <A-5> <cmd>FloatermToggle five<CR>

tnoremap <A-h> <cmd>FloatermToggle<CR>

nnoremap <leader>vd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <leader>vrn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd <cmd>lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vfm <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>vss <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <leader>vsw <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <leader>dst <Plug>VimspectorReset
nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
vnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>ph :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
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
