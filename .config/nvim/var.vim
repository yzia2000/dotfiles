let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
let g:bujo#window_width = 40

let test#strategy = "floaterm"

let g:vim_http_tempbuffer = 1
let g:floaterm_width=0.9
let g:indentLine_enabled=0

let g:suda_smart_edit = 1

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

let g:tex_flavor="latex"
let g:vimtex_parser_bib_backend="biber"

let g:leetcode_browser = 'firefox'
let g:tex_conceal = ''

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:netrw_banner=0	    " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_winsize=25      " winsize set
let g:netrw_localrmdir='rm -r'
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

if has('nvim-0.5')
  augroup lsp
    au!
    " au FileType java lua require('jdtls').start_or_attach({cmd = {'jdtls', '-data', '/home/yushi/workspace', '--add-modules=ALL-SYSTEM', '--add-opens java.base/java.util=ALL-UNNAMED', '--add-opens java.base/java.lang=ALL-UNNAMED', '-Dlog.protocol=true', '-Dlog.level=ALL'}})
    au FileType java lua require('jdtls').start_or_attach({cmd = {'jdtls', '-data', '/home/yushi/.jdtls-workspace'}})
  augroup end
endif

command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

" let g:compe = {}
" let g:compe.enabled = v:true
" let g:compe.autocomplete = v:true
" let g:compe.debug = v:false
" let g:compe.min_length = 1
" let g:compe.preselect = 'enable'
" let g:compe.throttle_time = 80
" let g:compe.source_timeout = 200
" let g:compe.resolve_timeout = 800
" let g:compe.incomplete_delay = 400
" let g:compe.max_abbr_width = 100
" let g:compe.max_kind_width = 100
" let g:compe.max_menu_width = 100
" let g:compe.documentation = v:true

" let g:compe.source = {}
" let g:compe.source.path = v:true
" let g:compe.source.buffer = v:false
" let g:compe.source.calc = v:false
" let g:compe.source.nvim_lsp = v:true
" let g:compe.source.nvim_lua = v:true
" " let g:compe.source.vsnip = v:true
" let g:compe.source.ultisnips = v:false
" " let g:compe.source.luasnip = v:true
" let g:compe.source.emoji = v:false
" let g:compe.source.treesitter = v:false
" let g:shfmt_opt="-ci"
" let g:neoformat_only_msg_on_error = 1
"
lua vim.lsp.set_log_level('warn')
