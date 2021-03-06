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
