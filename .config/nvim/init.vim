syntax on
filetype plugin indent on

set exrc
set nohlsearch
set nopaste
set smartcase
set noerrorbells
set hidden
set nobackup
set noswapfile
set undodir=~/.undodir
set undofile
set number rnu
set ruler
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4 softtabstop=4
set incsearch
set expandtab
set nowrap
set colorcolumn=80
set cmdheight=2
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

Plug 'kassio/neoterm'

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim' 

" Plug 'sheerun/vim-polyglot'

Plug 'ianding1/leetcode.vim'
Plug 'vim-utils/vim-man'
Plug 'tpope/vim-fugitive'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'
Plug 'mattn/emmet-vim'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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
set laststatus=2
set statusline=%F%m%r%h%w\
set statusline+=%{fugitive#statusline()}\
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [line\ %l\/%L]
set statusline=\ %f%m%r%h%w\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)

" Pasting
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>p "_dP
nnoremap <leader>Y gg"+yG

" Color scheme
colorscheme space-vim-dark
set background=dark
set termguicolors                    " Enable GUI colors for the terminal to get truecolor

" txt files
autocmd BufRead,BufNewFile *.txt set wrap 
autocmd BufRead,BufNewFile *.txt set linebreak

" c/cpp specific bindings
autocmd FileType cpp nnoremap <buffer> <leader>r :w <CR> :te g++ % -o %<_out && ./%<_out
autocmd FileType cpp nnoremap <buffer> <leader>t :w <CR> :te g++ % -o %<_out && ./%<_out < 
autocmd FileType cpp nnoremap <buffer> <leader>ks :w <CR> :te python3 /home/yushi/Documents/kattis/submit.py %
autocmd FileType cpp nnoremap <buffer> <leader>kt :w <CR> :te python3 /home/yushi/Documents/kattis/test.py %<
autocmd FileType cpp nnoremap <leader>lt :LeetCodeTest<cr>
autocmd FileType cpp nnoremap <leader>ls :LeetCodeSubmit<cr>
autocmd FileType c nnoremap <buffer> <leader>r :w <CR> :te gcc -g % -o %< && ./%< < 

autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!docx2text "%"

" java specific bindings
autocmd FileType java nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :compiler gradlew <CR> :make run <CR>
autocmd FileType java nnoremap <buffer> <leader>c :w <CR> :!clear <CR> :compiler gradlew <CR> :make build <CR>
autocmd FileType java nnoremap <buffer> <leader>t :w <CR> :!clear <CR> :compiler gradlew <CR> :make test <CR>

" Python specific bindings
autocmd FileType python nnoremap <buffer> <leader>r :w <CR> :te python %

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

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
let g:leetcode_browser = 'firefox'

let g:tex_conceal = ''

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
au BufEnter * lua require'completion'.on_attach()
let g:completion_chain_complete_list = {
            \   'default' : {
            \       'default' : [
            \           {'complete_items': ['lsp', 'snippet', 'path' ]},
            \           {'mode': '<c-p>'},
            \           {'mode': '<c-n>'},
            \       ]
            \   }
            \}

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
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

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

nnoremap <leader>teu :1Ttoggle<CR>
nnoremap <leader>tei :2Ttoggle<CR>
nnoremap <leader>teo :3Ttoggle<CR>
nnoremap <leader>tep :4Ttoggle<CR>
nnoremap <leader>teca :TcloseAll<CR>
nnoremap <Leader>rr :call neoterm#clear() \| call neoterm#exec(['!!', '', ''])<CR>

noremap <C-q> :TcloseAll<CR>

nnoremap <leader>ter :Tnew <CR>

tnoremap <C-^> <C-\><C-n><C-^>
tnoremap <C-q> <C-\><C-n><C-w><C-q>
tnoremap <C-n> <C-\><C-n>
tnoremap <C-u> <C-\><C-n><C-w><C-k>
nnoremap <C-d> <C-w><C-j>a

nnoremap <leader>hh :wincmd h<CR>
nnoremap <leader>jj :wincmd j<CR>
nnoremap <leader>kk :wincmd k<CR>
nnoremap <leader>ll :wincmd l<CR>

au BufEnter * set indentexpr=nvim_treesitter#indent()
let g:neoterm_default_mod = 'botright'
let g:neoterm_size = 10
let g:neoterm_autoinsert = 1
let g:neoterm_fixedsize = 1
