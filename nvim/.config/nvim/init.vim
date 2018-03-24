let g:config_file_location=$HOME.'/.config/nvim/'
let g:runtime_data_location=$HOME.'/.local/share/nvim/'

exe 'set runtimepath+='. g:config_file_location

" All hotkeys, not dependant on plugins, are mapped here.
exe 'source '. g:config_file_location. 'mappings.vim'

" All of the Vim configuration.
exe 'source '. g:config_file_location. 'config.vim'

" New commands
exe 'source '. g:config_file_location. 'commands.vim'

" Custom functions.
exe 'source '. g:config_file_location. 'functions.vim'

" Load plugin-specific configuration.
exe 'source '. g:config_file_location. 'plugins.vim'

" Load platform-specific configuration.
exe 'source '. g:config_file_location. 'platforms.vim'

" Auto commands.
exe 'source '. g:config_file_location. 'autocmds.vim'
