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

map <leader>v "+p
map <leader>y "+y

" Set comments italic
highlight Comment cterm=italic

" Cursor change
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"

set background=dark
set t_Co=256                         " Enable 256 colors
set termguicolors                    " Enable GUI colors for the terminal to get truecolor

" txt files
autocmd BufRead,BufNewFile *.txt set wrap 
autocmd BufRead,BufNewFile *.txt set linebreak
