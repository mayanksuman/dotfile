if exists('g:vim_plug_installing_plugins')
	Plug 'xolox/vim-notes'
	finish
endif

exe 'let g:notes_directories=['''.g:runtime_data_location.'notes'']'
let g:notes_suffix = '.md'
let g:notes_title_sync='rename_file'
