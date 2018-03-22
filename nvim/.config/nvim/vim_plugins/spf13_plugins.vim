if exists('g:vim_plug_installing_plugins')
	Plug 'rhysd/conflict-marker.vim'
	Plug 'terryma/vim-multiple-cursors'
"	Plug 'powerline/fonts'
"	Plug 'ryanoasis/nerd-fonts' " very large font set
	Plug 'bling/vim-bufferline'
	"Plug 'jistr/vim-nerdtree-tabs'
	Plug 'vim-scripts/restore_view.vim'
	Plug 'osyo-manga/vim-over'
	Plug 'kana/vim-textobj-indent'
	Plug 'gcmt/wildfire.vim'
	Plug 'reedes/vim-litecorrect'
	Plug 'reedes/vim-textobj-sentence'
	Plug 'reedes/vim-textobj-quote'
	Plug 'reedes/vim-wordy'
	Plug 'scrooloose/nerdcommenter'
	Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
	Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }
	Plug 'ap/vim-css-color', { 'for': ['css','less','sass','javascript','python','stylus'] }
	Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' } " sass scss syntax support
	Plug 'tpope/vim-rails', { 'for': 'ruby' }
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }
	Plug 'quentindecock/vim-cucumber-align-pipes'
	Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
	Plug 'maxbrunsfeld/vim-yankstack'
endif

" for vim-scripts/restore_view.vim
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']
