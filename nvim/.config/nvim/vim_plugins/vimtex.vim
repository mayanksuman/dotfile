if exists('g:vim_plug_installing_plugins')
	Plug 'lervag/vimtex', { 'for': ['tex','latex'] }
	finish
endif

let g:vimtex_compiler_progname = 'nvr'
