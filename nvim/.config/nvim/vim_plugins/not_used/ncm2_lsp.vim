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
"	Plug 'autozimu/LanguageClient-neovim', {
"	\ 'branch': 'next',
"	\ 'do': 'bash install.sh',
"	\ 'for': ['rust','javascript','python','c','cpp','php']
"	\ }
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'ncm2/ncm2-vim-lsp'
	finish
endif

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c

au TextChangedI * call ncm2#auto_trigger()

" Required for operations modifying multiple buffers like rename.
set hidden

" let g:LanguageClient_serverCommands = {
" 			\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
" 			\ 'javascript': ['javascript-typescript-stdio'],
" 			\ 'typescript': ['javascript-typescript-stdio'],
" 			\ 'python': ['pyls'],
" 			\ 'c': ['clangd'],
" 			\ 'cpp': ['clangd'],
" 			\ 'php': ['php-language-server'],
" 			\ }
"
" " Automatically start language servers.
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_loggingFile = '/tmp/lc.log'
" let g:LanguageClient_loggingLevel = 'DEBUG'
"
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> fs :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"
"
" c, cpp
" clangd -- from clang
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
" python
" pip install 'python-language-server[all]'
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" javascript, typescript
" npm install -g typescript typescript-language-server
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
      \ })
endif
" ruby
" gem install solargraph
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif
" php
" Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}
au User lsp_setup call lsp#register_server({
     \ 'name': 'php-language-server',
     \ 'cmd': {server_info->['php', expand('~/.vim/plugged/php-language-server/bin/php-language-server.php')]},
     \ 'whitelist': ['php'],
     \ })
" css/Less/Sass
" npm install -g vscode-css-languageserver-bin
if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
        \ })
endif
" go
" go get -u github.com/sourcegraph/go-langserver
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
endif
" rust
" rustup update
" rustup component add rls-preview rust-analysis rust-src
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif
