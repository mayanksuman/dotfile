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
		if !exists('g:ms_vim_no_restore_cursor')
			autocmd BufWinEnter * call ResCur()
		endif

		" No more complaining about untitled documents
		autocmd FocusLost silent! :wa

		" When editing a file, always jump to the last cursor position.
		" This must be after the uncompress commands.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line ("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

		" Leave the return key alone when in command line windows, since it's used
		" to run commands there.
		autocmd! CmdwinEnter * :unmap <cr>
		autocmd! CmdwinLeave * :call MapCR()

		" Resize splits when the window is resized
		" from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
		autocmd VimResized * :wincmd =

		" Remove trailing whitespaces and ^M chars
		" To disable the stripping of whitespace, add the following to your
		" .vimrc.before.local file:
		" let g:ms_vim_keep_trailing_whitespace = 1
		autocmd FileType c,cpp,java,go,php,javascript,puppet,python,
					\rust,twig,xml,yml,perl,sql,html,css,
					\vim,markdown,coffee,ruby,matlab,tex
					\ autocmd BufWritePre <buffer>
					\ if !exists('g:ms_vim_keep_trailing_whitespace')
					\| call StripTrailingWhitespace() | endif

		" Close Vim if NERDTree is the last buffer
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
					\&& b:NERDTreeType == "primary") | q | endif

		autocmd BufWinLeave *.* mkview!
		autocmd BufWinEnter *.* silent loadview
		autocmd BufWritePost * :silent! :syntax sync fromstart<cr>:redraw!<cr>
		autocmd GUIEnter * set visualbell t_vb=
	augroup END

	" Transparent editing of gpg encrypted files.
	" By Wouter Hanegraaff
	augroup encrypted
		autocmd!

		" First make sure nothing is written to ~/.viminfo while editing
		" an encrypted file.
		autocmd BufReadPre,FileReadPre *.gpg set viminfo=
		" We don't want a various options which write unencrypted data to disk
		autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

		" Switch to binary mode to read the encrypted file
		autocmd BufReadPre,FileReadPre *.gpg set bin
		autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
		" (If you use tcsh, you may need to alter this line.)
		autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

		" Switch to normal mode for editing
		autocmd BufReadPost,FileReadPost *.gpg set nobin
		autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
		autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

		" Convert all text to encrypted text before writing
		" (If you use tcsh, you may need to alter this line.)
		autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
		" Undo the encryption so we are back in the normal text, directly
		" after the file has been written.
		autocmd BufWritePost,FileWritePost *.gpg u
	augroup END
endif
