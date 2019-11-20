syntax on
set nocompatible
set hidden
set backup
set backupdir=~/.backups
set number
set ruler
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set nowrap
set backspace=2

filetype off


set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
  
  Plugin 'airblade/vim-rooter'
  Plugin 'tfnico/vim-gradle'
  Plugin 'dragfire/Improved-Syntax-Highlighting-Vim'
  Plugin 'taketwo/vim-ros'
  Plugin 'szymonmaszke/vimpyter'
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'tpope/vim-fugitive'
  Plugin 'vim-syntastic/syntastic'
  Plugin 'vim-scripts/Arduino-syntax-file'
  Plugin 'octol/vim-cpp-enhanced-highlight'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
  Plugin 'Raimondi/delimitMate'
  Plugin 'rafi/awesome-vim-colorschemes'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'bling/vim-bufferline'
  Plugin 'chriskempson/base16-vim'
  Plugin 'Yggdroot/indentLine'
  Plugin 'sudar/vim-arduino-syntax'
  Plugin 'sudar/vim-arduino-snippets'

 
call vundle#end()

filetype plugin on

" Search down into subfolders
set path+=**

" Display all matching files when tab complete
set wildmenu

" Create 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R .

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


"For syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_c_checkers = [ 'clang_tidy', 'clang' ]
let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_clang_args = '-Wall -Werror -Wextra -Iinclude'
let g:syntastic_c_clang_tidy_args = '-checks=*'
let g:syntastic_c_compiler_options = '-Wall -Iinclude'
let g:syntastic_c_include_dirs = [ '../include', 'include' ]
let g:syntastic_c_clang_tidy_post_args = ""

let g:syntastic_java_checkers = [ "checkstyle" ]
let g:syntastic_java_checkstyle_classpath = "~/checkstyle-8.23-all.jar"
let g:syntastic_java_checkstyle_conf_file = "~/checkstyle.xml"
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['python'],
                            \ 'passive_filetypes': ['html', 'javascript', 'c', 'c++', 'java'] }


" C/C++ syntax highlighting
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_dec1_highlight=1
let g:cpp_experimental_template_highlight=1
let g:cpp_concepts_highlight=1

" YCM
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_warning_symbol = '⚠'
let g:ycm_error_symbol = '✗'
let g:ycm_server_use_vim_stdout = 1
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf1.py'
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_enable_diagnostic_highlighting = 0
" let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }
" Delimitmate settings
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2

" YouCompleteMe and UltiSnips compatibility
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger="<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
  
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

imap <expr> <CR> pumvisible()
  \ ? "\<C-Y>"
  \ : "<Plug>delimitMateCR"

" Pasting
let s:clip = '/mnt/c/Windows/System32/clip.exe' 
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end

map <silent> "+p :r !powershell.exe -Command Get-Clipboard<CR>"
map <C-v> "+p

" Set comments italic
highlight Comment cterm=italic

" c/cpp specific bindings
if &filetype ==# 'c' || &filetype ==# 'cpp'
  map <leader>r :w <CR> :!clear <CR> :!clang++ -lm % -o %<_out && ./%<_out <CR>
  map <leader>m :w <CR> :!clear; cmake .; make; clear<CR> :!./%<_out
  map <leader>b :w <CR> :!clear; cmake .; make; clear<CR><CR>
  map <leader>s :w <CR> :!clear; python3 submit.py %; clear <CR><CR>
  map <leader>t :w <CR> :!clear; python3 test.py %<<CR>
endif

" java specific bindings
autocmd FileType java map <leader>r :w <CR> :!clear <CR> :compiler gradlew <CR> :make run <CR>
autocmd FileType java map <leader>c :w <CR> :!clear <CR> :compiler gradlew <CR> :make build <CR>
autocmd FileType java map <leader>t :w <CR> :!clear <CR> :compiler gradlew <CR> :make test <CR>

if has('python')
endif

