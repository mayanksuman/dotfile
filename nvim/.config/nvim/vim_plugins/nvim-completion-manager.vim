if exists('g:vim_plug_installing_plugins')
	Plug 'roxma/nvim-completion-manager'
	Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
	if !has('nvim')
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	finish
endif


" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
			\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
			\ 'javascript': ['javascript-typescript-langserver'],
			\ 'typescript': ['javascript-typescript-langserver'],
			\ 'python': ['pyls'],
			\ 'c': ['clangd'],
			\ 'cpp': ['clangd'],
			\ 'php': ['php-language-server'],
			\ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
