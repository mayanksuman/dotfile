" ----------------------------------------
" Auto Commands
" ----------------------------------------

if has('autocmd')
	augroup MyAutoCommands
		" Clear the auto command group so we don't define it multiple times
		" Idea from http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
		autocmd!
		" No formatting on o key newlines
		autocmd BufNewFile,BufEnter * set formatoptions-=o

		" No more complaining about untitled documents
		autocmd FocusLost silent! :wa

		" When editing a file, always jump to the last cursor position.
		" This must be after the uncompress commands.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line ("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

		" Fix trailing whitespace in my most used programming langauges
		autocmd BufWritePre *.py,*.coffee,*.rb,*.erb,*.md,*.scss,*.vim,Cakefile,
					\*.hbs
					\ silent! :StripTrailingWhiteSpace

		" Help mode bindings
		" <enter> to follow tag, <bs> to go back, and q to quit.
		" From http://ctoomey.com/posts/an-incremental-approach-to-vim/
		autocmd filetype help nnoremap <buffer><cr> <c-]>
		autocmd filetype help nnoremap <buffer><bs> <c-T>
		autocmd filetype help nnoremap <buffer>q :q<CR>

		" Fix accidental indentation in html files
		" from http://morearty.com/blog/2013/01/22/fixing-vims-indenting-of-html-files.html
		autocmd FileType html setlocal indentkeys-=*<Return>

		" Leave the return key alone when in command line windows, since it's used
		" to run commands there.
		autocmd! CmdwinEnter * :unmap <cr>
		autocmd! CmdwinLeave * :call MapCR()

		" Resize splits when the window is resized
		" from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
		au VimResized * :wincmd =



		" Remove trailing whitespaces and ^M chars
		" To disable the stripping of whitespace, add the following to your
		" .vimrc.before.local file:
		"   let g:ms_vim_keep_trailing_whitespace = 1
		autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql,html,css autocmd BufWritePre <buffer> if !exists('g:ms_vim_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif


		autocmd BufNewFile,BufRead *.coffee set filetype=coffee

		" Workaround vim-commentary for Haskell
		autocmd FileType haskell setlocal commentstring=--\ %s
		" Workaround broken colour highlighting in Haskell
		autocmd FileType haskell,rust setlocal nospell

		" Close Vim if NERDTree is the last buffer
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
					\&& b:NERDTreeType == "primary") | q | endif

		autocmd BufWinLeave *.* mkview!
		autocmd BufWinEnter *.* silent loadview
		autocmd BufWritePost * :silent! :syntax sync fromstart<cr>:redraw!<cr>
		autocmd GUIEnter * set visualbell t_vb=
	augroup END

	if !exists('g:ms_vim_no_restore_cursor')
		augroup resCur
			autocmd!
			autocmd BufWinEnter * call ResCur()
		augroup END
	endif
endif
