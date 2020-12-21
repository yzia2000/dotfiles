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
set smartcase
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

let g:polyglot_disabled = ['csv']

let mapleader = " "
inoremap <C-c> <esc>
vnoremap . :normal .<CR>

call plug#begin()

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim' 

Plug 'ianding1/leetcode.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-utils/vim-man'
Plug 'tpope/vim-fugitive'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'puremourning/vimspector'

call plug#end()

command Sw :execute ':silent w !sudo tee % > /dev/null' | :edit!

nnoremap <C-p> :GFiles<CR>
noremap <C-space> :Files<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>


let g:netrw_banner=0	    " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
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
colorscheme ayu
set background=dark
set termguicolors                    " Enable GUI colors for the terminal to get truecolor


" txt files
autocmd BufRead,BufNewFile *.txt set wrap 
autocmd BufRead,BufNewFile *.txt set linebreak

" c/cpp specific bindings
autocmd FileType cpp nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :!g++ % -o %<_out && ./%<_out <CR>
autocmd FileType cpp nnoremap <buffer> <leader>t :w <CR> :!clear <CR> :!g++ % -o %<_out <CR> :!./%<_out < 
autocmd FileType cpp nnoremap <buffer> <leader>ks :w <CR> :!clear; python3 /home/yushi/Documents/kattis/submit.py %; clear <CR><CR>
autocmd FileType cpp nnoremap <buffer> <leader>kt :w <CR> :!clear; python3 /home/yushi/Documents/kattis/test.py %<<CR>
autocmd FileType cpp nnoremap <buffer> <leader>d :w <CR> :!clear <CR> :!g++ -g % -o %<_out <CR> :!gdb %<_out <CR>
autocmd FileType cpp nnoremap <leader>lt :LeetCodeTest<cr>
autocmd FileType cpp nnoremap <leader>ls :LeetCodeSubmit<cr>

autocmd FileType c nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :!gcc -g % -o %< <CR> :!./%< < 
autocmd FileType c nnoremap <buffer> <leader>d :w <CR> :!clear <CR> :!gcc -g % -o %< <CR> :!gdb %< <CR>

autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!docx2text "%"

" java specific bindings
autocmd FileType java nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :compiler gradlew <CR> :make run <CR>
autocmd FileType java nnoremap <buffer> <leader>c :w <CR> :!clear <CR> :compiler gradlew <CR> :make build <CR>
autocmd FileType java nnoremap <buffer> <leader>t :w <CR> :!clear <CR> :compiler gradlew <CR> :make test <CR>

" Python specific bindings
autocmd FileType python nnoremap <buffer> <leader>r :w <CR> :!clear; python % <CR>

autocmd BufRead,BufNewFile *.svb set ft=vbnet

" latex specific bindings
autocmd Filetype tex autocmd BufUnload <buffer> VimtexClean

autocmd Filetype go nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :!go run % <CR>

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
let t:is_transparent=1
hi Normal guibg=NONE ctermbg=NONE
highlight LineNr guifg=grey30

function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
        highlight LineNr guifg=grey30
    else
        set background=dark
        let t:is_transparent = 0
    endif
endfunction

let g:tex_flavor="latex"
let g:vimtex_parser_bib_backend="biber"

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
let g:leetcode_browser = 'firefox'

let g:tex_conceal = ''

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
require'lspconfig'.jedi_language_server.setup{ on_attach=require'completion'.on_attach }
require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
EOF

nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
