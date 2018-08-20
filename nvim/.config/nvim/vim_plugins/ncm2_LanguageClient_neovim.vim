if exists('g:vim_plug_installing_plugins')
	Plug 'ncm2/ncm2'
	Plug 'roxma/nvim-yarp'
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'
	Plug 'ncm2/ncm2-tmux'
	Plug 'ncm2/ncm2-html-subscope'
	Plug 'ncm2/ncm2-markdown-subscope'
	"Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
	"Plug 'ncm2/ncm2-pyclang', { 'for': ['c','cpp'] }
	Plug 'ncm2/ncm2-ultisnips'
	Plug 'filipekiss/ncm2-look.vim'
	Plug 'lervag/vimtex', { 'for': ['tex','latex'] }
 	Plug 'autozimu/LanguageClient-neovim', {
 	\ 'branch': 'next',
 	\ 'do': 'bash install.sh',
 	\ 'for': ['rust','javascript','python','c','cpp','php']
 	\ }
" 	Plug 'prabirshrestha/async.vim'
" 	Plug 'prabirshrestha/vim-lsp'
" 	Plug 'ncm2/ncm2-vim-lsp'
	finish
endif

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c

au TextChangedI * call ncm2#auto_trigger()

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
			\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
			\ 'javascript': ['javascript-typescript-stdio'],
			\ 'typescript': ['javascript-typescript-stdio'],
			\ 'python': ['pyls'],
			\ 'c': ['clangd'],
			\ 'cpp': ['clangd'],
			\ 'php': ['php-language-server'],
			\ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loggingFile = '/tmp/lc.log'
let g:LanguageClient_loggingLevel = 'DEBUG'
autocmd filetype python LanguageClientStart
autocmd filetype c LanguageClientStart
autocmd filetype cpp LanguageClientStart
autocmd filetype rust LanguageClientStart
autocmd filetype javascript LanguageClientStart
autocmd filetype typescript LanguageClientStart
autocmd filetype php LanguageClientStart

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> fs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>



