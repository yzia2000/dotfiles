syntax on
filetype indent on

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
"set backspace=2
set foldmethod=indent
set nofoldenable
set shortmess+=c

filetype off


call plug#begin()
  
  Plug 'airblade/vim-rooter'
  "Plug 'vhda/verilog_systemverilog.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-utils/vim-man'
  Plug 'VundleVim/Vundle.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'Raimondi/delimitMate'
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'scrooloose/nerdcommenter'
  Plug 'bling/vim-bufferline'
  Plug 'Yggdroot/indentLine'
  Plug 'mbbill/undotree'
  Plug 'honza/vim-snippets'

call plug#end()

filetype plugin on

" Search down into subfolders
set path+=**

" Display all matching files when tab complete
set wildmenu

" Create 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R .

nnoremap <C-p> :GFiles<CR>
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
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Color scheme
set termguicolors
colo ayu

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
let g:loaded_delimitMate = 1
"imap <expr> <CR> pumvisible()
  "\ ? "\<C-Y>"
  "\ : "<Plug>delimitMateCR"

" Pasting
let s:clip = '/mnt/c/Windows/System32/clip.exe' 
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end

map <silent> "+p :r !powershell.exe -Command Get-Clipboard<CR>"
map <leader>v "+p

" Set comments italic
highlight Comment cterm=italic

" c/cpp specific bindings
autocmd FileType cpp nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :!clang++ -lm % -o %<_out && ./%<_out <CR>
autocmd FileType cpp nnoremap <buffer> <leader>m :w <CR> :!clear; cmake .; make; clear<CR> :!./%<_out
autocmd FileType cpp nnoremap <buffer> <leader>b :w <CR> :!clear; cmake .; make; clear<CR><CR>
autocmd FileType cpp nnoremap <buffer> <leader>s :w <CR> :!clear; python3 submit.py %; clear <CR><CR>
autocmd FileType cpp nnoremap <buffer> <leader>t :w <CR> :!clear; python3 test.py %<<CR>
autocmd FileType cpp nnoremap <buffer> <leader>d :w <CR> :!clear <CR> :!g++ -g % -o %<_out <CR> :!gdb %<_out <CR>

autocmd FileType c nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :!gcc -g % -o %< <CR> :!./%< < 
autocmd FileType c nnoremap <buffer> <leader>d :w <CR> :!clear <CR> :!gcc -g % -o %< <CR> :!gdb %< <CR>


" java specific bindings
autocmd FileType java nnoremap <buffer> <leader>r :w <CR> :!clear <CR> :compiler gradlew <CR> :make run <CR>
autocmd FileType java nnoremap <buffer> <leader>c :w <CR> :!clear <CR> :compiler gradlew <CR> :make build <CR>
autocmd FileType java nnoremap <buffer> <leader>t :w <CR> :!clear <CR> :compiler gradlew <CR> :make test <CR>

if has('python')
endif

if &term =~ '256color'
      " disable Background Color Erase (BCE) so that color schemes
      " render properly when inside 256-color tmux and GNU screen.
      " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

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

nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>rr <Plug>(coc-rename)
nmap <silent>g[ <Plug>(coc-diagnostic-prev)
nmap <silent>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

"function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"inoremap <silent><expr> <C-space> coc#refresh()

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

let g:polyglot_disabled = ['csv']
