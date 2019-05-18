" ----------------------------------------
" Plugins using vim-plug
" ----------------------------------------

let g:plug_shallow = 1
set nocompatible " Don't use compatibility mode
filetype off     " required for plug install
let g:plugin_config_location=g:config_file_location.'vim_plugins/'

" Specify a directory for plugins (for Neovim: $HOME/.local/share/nvim/plugged)
call plug#begin(g:runtime_data_location . 'plugged')
" Source all the plugins with a global variable set that ensures only the
" Plugin 'name' code will be called.
let g:vim_plug_installing_plugins = 1

for file in split(glob(g:plugin_config_location.'*.vim'), '\n')
	exe 'source' fnameescape(file)
endfor
for file in split(glob(g:plugin_config_location.'custom/*.vim'), '\n')
	exe 'source' fnameescape(file)
endfor

unlet g:vim_plug_installing_plugins

call plug#end()

" Automatically detect file types. (must turn on after vim-plug)
filetype plugin indent on
filetype plugin on
if !exists("g:syntax_on")
    syntax enable
endif

" Source all the plugin files again, this time loading their configuration.
if isdirectory(g:runtime_data_location . 'plugged')
	for file in split(glob(g:plugin_config_location.'*.vim'), '\n')
		exe 'source' file
	endfor
	for file in split(glob(g:plugin_config_location.'custom/*.vim'), '\n')
		exe 'source' file
	endfor
endif
