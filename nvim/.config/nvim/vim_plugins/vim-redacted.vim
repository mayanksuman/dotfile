if exists('g:vim_plug_installing_plugins')
	Plug 'dbmrq/vim-redacted'
	finish
endif

nmap <leader>r <Plug>Redact
vmap <leader>r <Plug>Redact

nmap <leader>r! <Plug>Redact!
vmap <leader>r! <Plug>Redact!
