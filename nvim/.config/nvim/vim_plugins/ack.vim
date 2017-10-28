if exists('g:vim_plug_installing_plugins')
	Plug 'mileszs/ack.vim'
	finish
endif

if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
