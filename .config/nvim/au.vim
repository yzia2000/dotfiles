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

" au BufEnter * lua require'completion'.on_attach()

au FileType dap-repl lua require('dap.ext.autocompl').attach()

autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

augroup fmt
  autocmd!
  autocmd BufWritePre *.go silent! undojoin | silent! Neoformat gofmt
  " autocmd BufWritePre *.sbt,*.scala silent! undojoin | MetalsOrganizeImports
  autocmd BufWritePre *.sbt,*.scala silent! undojoin | lua vim.lsp.buf.format({ async = false })
  autocmd BufWritePre *.sql silent! undojoin | silent! Neoformat pg_format
  " autocmd BufWritePre *.ts,*.js,*.tsx,*.jsx,*.json silent! undojoin | silent! Prettier
augroup END

"augroup javascript_format
"  autocmd!
"  autocmd BufWritePre *.ts,*.js,*.tsx,*.jsx silent! undojoin | silent! lua vim.lsp.buf.format({ async = false })
"augroup END

augroup lsp
  au!
  au FileType java lua require('jdtls').start_or_attach({cmd = {'jdtls', '-data', '/home/yushi/.jdtlsworkspace'}})
augroup end

autocmd BufRead,BufEnter *.astro set filetype=astro
