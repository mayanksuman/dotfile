if exists('g:vim_plug_installing_plugins')
	Plug 'terryma/vim-multiple-cursors'
"	Plug 'powerline/fonts'
"	Plug 'ryanoasis/nerd-fonts' " very large font set
	Plug 'bling/vim-bufferline'
	Plug 'vim-scripts/restore_view.vim'
	Plug 'kana/vim-textobj-indent'
	Plug 'gcmt/wildfire.vim'
	Plug 'reedes/vim-litecorrect'
	Plug 'reedes/vim-textobj-sentence'
	Plug 'reedes/vim-textobj-quote'
	Plug 'reedes/vim-wordy'
	
	Plug 'tpope/vim-rails', { 'for': 'ruby' }
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }
	Plug 'maxbrunsfeld/vim-yankstack'
endif

" for vim-scripts/restore_view.vim
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']
