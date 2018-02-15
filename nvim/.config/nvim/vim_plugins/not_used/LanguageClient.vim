if exists('g:vim_plug_installing_plugins')
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'yami-beta/asyncomplete-omni.vim'
	Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
	Plug 'prabirshrestha/asyncomplete-buffer.vim'
	finish
endif

if executable('javascript-typescript-stdio')
	" npm install -g javascript-typescript-langserver
	au User lsp_setup call lsp#register_server({
				\ 'name': 'javascript-typescript-stdio',
				\ 'cmd': {server_info->['javascript-typescript-stdio']},
				\ 'whitelist': ['javascript','typescript'],
				\ })
endif

if executable('pyls')
	" pip install python-language-server
	au User lsp_setup call lsp#register_server({
				\ 'name': 'pyls',
				\ 'cmd': {server_info->['pyls']},
				\ 'whitelist': ['python'],
				\ })
endif

if executable('clangd')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'clangd',
		\ 'cmd': {server_info->['clangd']},
		\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
		\ })
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
    \ 'name': 'omni',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['html'],
    \ 'completor': function('asyncomplete#sources#omni#completor')
\  }))


call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
\ }))

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
\ }))


"if exists('g:vim_plug_installing_plugins')
"Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
"finish
"endif

"" Automatically start language servers.
"let g:LanguageClient_autoStart = 1

"" Minimal LSP configuration for JavaScript
"let g:LanguageClient_serverCommands = {}
"if executable('javascript-typescript-stdio')
"let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
"" Use LanguageServer for omnifunc completion
"autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
"else
"echo "javascript-typescript-stdio not installed!\n"
"endif

"" Minimal LSP configuration for Python
"let g:LanguageClient_serverCommands.python = ['pyls']

"" Map renaming in python
"autocmd FileType python nnoremap <buffer>
"\ <leader>lr :call LanguageClient_textDocument_rename()<cr>

