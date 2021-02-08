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
set completeopt=menuone,noinsert,noselect
set signcolumn=yes

let mapleader = " "
inoremap <C-c> <esc>
vnoremap . :normal .<CR>

call plug#begin()

Plug 'vim-test/vim-test'

Plug 'nicwest/vim-http'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['typescriptreact', 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-markdown'

Plug 'voldikss/vim-floaterm'

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim' 

Plug 'norcalli/nvim-colorizer.lua'


Plug 'ianding1/leetcode.vim'
Plug 'vim-utils/vim-man'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'SirVer/ultisnips'
Plug 'vuciv/vim-bujo'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

Plug 'dstein64/vim-startuptime'

call plug#end()


command Sw :w !sudo tee %

let g:netrw_banner=0	    " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_winsize=25      " winsize set
let g:netrw_localrmdir='rm -r'
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" statusline

" Pasting
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>p "_dP
nnoremap <leader>pc "+p
nnoremap <leader>Y gg"+yG

" Color scheme
" colorscheme space-vim-dark
colorscheme purify
" set background=dark
set termguicolors                    " Enable GUI colors for the terminal to get truecolor

" txt files
autocmd BufRead,BufNewFile *.txt set wrap 
autocmd BufRead,BufNewFile *.txt set linebreak

" c/cpp specific bindings
autocmd FileType cpp nnoremap <buffer> <leader>r :w <CR> :FloatermNew g++ % -o %<_out && ./%<_out
autocmd FileType cpp nnoremap <buffer> <leader>t :w <CR> :FloatermNew g++ % -o %<_out && ./%<_out < 
autocmd FileType cpp nnoremap <buffer> <leader>ks :w <CR> :FloatermNew python3 /home/yushi/Documents/kattis/submit.py %
autocmd FileType cpp nnoremap <buffer> <leader>kt :w <CR> :FloatermNew python3 /home/yushi/Documents/kattis/test.py %<
autocmd FileType cpp nnoremap <leader>lt :LeetCodeTest<cr>
autocmd FileType cpp nnoremap <leader>ls :LeetCodeSubmit<cr>
autocmd FileType c nnoremap <buffer> <leader>r :w <CR> :FloatermNew gcc -g % -o %< && ./%< < 

autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!docx2text "%"

" java specific bindings
autocmd FileType java nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :compiler gradlew <CR> :make run <CR>
autocmd FileType java nnoremap <buffer> <leader>c :w <CR> :!clear <CR> :compiler gradlew <CR> :make build <CR>
autocmd FileType java nnoremap <buffer> <leader>t :w <CR> :!clear <CR> :compiler gradlew <CR> :make test <CR>

" Python specific bindings
autocmd FileType python nnoremap <buffer> <leader>r :w <CR> :FloatermNew python %

autocmd BufRead,BufNewFile *.svb set ft=vbnet

" latex specific bindings
autocmd Filetype tex autocmd BufUnload <buffer> VimtexClean

autocmd Filetype go nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :!go run % <CR>

" Setup for all files

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

" Vim transparency
" let g:is_transparent=0
" hi Normal guibg=NONE ctermbg=NONE
" " highlight LineNr guifg=grey30
" 
" function! Toggle_transparent()
"     if g:is_transparent == 0
"         hi Normal guibg=NONE ctermbg=NONE
"         let g:is_transparent = 1
"         highlight LineNr guifg=grey30
"     else
"         set background=dark
"         let g:is_transparent = 0
"     endif
" endfunction

let g:tex_flavor="latex"
let g:vimtex_parser_bib_backend="biber"

let g:leetcode_browser = 'firefox'
let g:tex_conceal = ''

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
au BufEnter * lua require'completion'.on_attach()
" let g:completion_chain_complete_list = {
"             \   'default' : {
"             \       'default' : [
"             \           {'complete_items': ['lsp', 'snippet', 'path' ]},
"             \           {'mode': '<c-p>'},
"             \           {'mode': '<c-n>'},
"             \       ]
"             \   }
"             \}

lua require('lspConfigs')

lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

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

nnoremap <leader>hh :wincmd h<CR>
nnoremap <leader>jj :wincmd j<CR>
nnoremap <leader>kk :wincmd k<CR>
nnoremap <leader>ll :wincmd l<CR>

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  indent = { 
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

nmap <C-s> <Plug>BujoAddTodoNormal
imap <C-s> <Plug>BujoAddTodoInsert
nmap <C-s> <Plug>BujoChecknormal
imap <C-s> <Plug>BujoCheckinsert

let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
let g:bujo#window_width = 40

nmap <leader>ttn :TestNearest<CR>
nmap <leader>ttf :TestFile<CR>
nmap <leader>tts :TestSuite<CR>
nmap <leader>ttl :TestLast<CR>
nmap <leader>ttg :TestVisit<CR>

let test#strategy = "floaterm"
nmap <Leader>py <Plug>(Prettier)

nmap <leader>rnu :set number rnu<CR>
nmap <leader>run :set nonumber norelativenumber<CR>

let g:vim_http_tempbuffer = 1
