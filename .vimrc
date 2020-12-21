syntax on
filetype indent on

set nopaste
set smartcase
set noerrorbells
set nocompatible
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
set foldmethod=indent
set nofoldenable
set shortmess+=c
set timeoutlen=1000 ttimeoutlen=0
set cul
let mapleader = " "
inoremap <C-c> <esc>
vnoremap . :normal .<CR>

if has('python3')
endif

filetype off

let g:polyglot_disabled = ['csv']


call plug#begin()
  
  Plug 'ianding1/leetcode.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-utils/vim-man'
  Plug 'tpope/vim-fugitive'
  Plug 'rafi/awesome-vim-colorschemes'
  "Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdcommenter'
  Plug 'bling/vim-bufferline'
  Plug 'Yggdroot/indentLine'
  Plug 'mbbill/undotree'
  Plug 'honza/vim-snippets'
  "Plug 'ying17zi/vim-live-latex-preview'
  Plug 'lervag/vimtex'
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'mattn/emmet-vim'
  Plug 'puremourning/vimspector'
  Plug 'szw/vim-maximizer'

call plug#end()

filetype plugin on

" Search down into subfolders
set path+=**

" Display all matching files when tab complete
set wildmenu

" Create 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R .
command Sw :execute ':silent w !sudo tee % > /dev/null' | :edit!

nnoremap <C-p> :GFiles<CR>
nnoremap <C-@> :Files<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" Above enabled commads
" ^] to jump to tag under cursor
" g^] for ambiguous tags
" ^t to jump back up the tag stack

let g:netrw_banner=0	    " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" set makeprg=bundle\ exec\rspec\ -f\ QuickfixFormatter
" Run :make to run RSepc
" :cl to list errors
" :cc# to jump to error by number
" :cn and :cp to navigate forward and back

" Remove arrow keys
"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>

" statusline
set laststatus=2
set statusline=%F%m%r%h%w\
set statusline+=%{fugitive#statusline()}\
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [line\ %l\/%L]
set statusline=\ %f%m%r%h%w\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)

let g:bufferline_echo = 1

" C/C++ syntax highlighting
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_dec1_highlight=1
let g:cpp_experimental_template_highlight=1
let g:cpp_concepts_highlight=1

" Delimitmate settings
"let g:delimitMate_expand_space = 1
"let g:delimitMate_expand_cr =
"let g:loaded_delimitMate = 1
"imap <expr> <CR> pumvisible()
  "\ ? "\<C-Y>"
  "\ : "<Plug>delimitMateCR"

" Pasting
map <leader>v "+p
map <leader>y "+y

" Set comments italic
highlight Comment cterm=italic

" Cursor change
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"

" Color scheme
set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=^[[48;2;%lu;%lu;%lum        " set background color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme ayu
set background=dark
set t_Co=256                         " Enable 256 colors
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

" Coc settings
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <leader>gn <Plug>(coc-diagnostic-next-error)
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nnoremap <leader>cr :CocRestart

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<c-k>'

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

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:tex_flavor="latex"
let g:vimtex_parser_bib_backend="biber"

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
let g:leetcode_browser = 'firefox'

let g:tex_conceal = ''

