if exists('g:vim_plug_installing_plugins')
	Plug 'terryma/vim-multiple-cursors'
"	Plug 'powerline/fonts'
"	Plug 'ryanoasis/nerd-fonts' " very large font set
	Plug 'bling/vim-bufferline' "list of buffers in commandbar
	Plug 'vim-scripts/restore_view.vim' "restore cursor location and fold
	Plug 'gcmt/wildfire.vim'
	Plug 'maxbrunsfeld/vim-yankstack'
endif

" for vim-scripts/restore_view.vim
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']
