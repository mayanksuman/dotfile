if exists('g:vim_plug_installing_plugins')
  Plug 'scrooloose/syntastic'
  finish
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_c_compiler=['gcc']
let g:syntastic_cpp_compiler=['g++']
let g:syntastic_python_checkers = ['python3']
let g:syntastic_vala_compiler=['valac']
let g:syntastic_lua_checkers = ['luac']
let g:syntastic_r_checkers = ['lintr']
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['eslint']		"npm install eslint
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_css_checkers = ['csslint']			"npm install csslint
let g:syntastic_json_checkers = ['jsonlint']			"npm install textlint
let g:syntastic_yaml_checkers = ['yamllint']			"pip install yamllint
let g:syntastic_markdown_checkers = ['textlint']		"npm install textlint
let g:syntastic_text_checkers = ['textlint']
let g:syntastic_zsh_checkers = ['zsh']


let g:syntastic_csslint_options = "--warnings=none"
