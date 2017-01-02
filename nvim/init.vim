" try to run local vimrc settings specific to folder
try
	source vimrc.local
catch
endtry

let g:config_file_location='/home/mayank/.dotfile/nvim/'
let g:runtime_data_location='/home/mayank/.local/share/nvim/'

exe 'set runtimepath+='. g:config_file_location

" Load plugin-specific configuration.
exe 'source '. g:config_file_location. 'plugins.vim'

" Load platform-specific configuration.
exe 'source '. g:config_file_location. 'platforms.vim'

" All of the Vim configuration.
exe 'source '. g:config_file_location. 'config.vim'

" New commands
exe 'source '. g:config_file_location. 'commands.vim'

" Small custom functions.
exe 'source '. g:config_file_location. 'functions.vim'

" All hotkeys, not dependant on plugins, are mapped here.
exe 'source '. g:config_file_location. 'mappings.vim'

" Auto commands.
exe 'source '. g:config_file_location. 'autocmds.vim'

" try to run local vimrc settings specific to folder
" again if something has changed
try
	source vimrc.local
catch
endtry

