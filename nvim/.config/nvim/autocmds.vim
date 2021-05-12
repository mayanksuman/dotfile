" ----------------------------------------
" Auto Commands
" ----------------------------------------

if has('autocmd')
	augroup MyAutoCommands
		" Clear the auto command group so we don't define it multiple times
		" Idea from http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
		autocmd!

		" Write all files on focus lost
		autocmd FocusLost silent! :wa

		" Resize splits when the window is resized
		" from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
		autocmd VimResized * :wincmd =

		" Remove trailing whitespaces and ^M chars
		autocmd FileType c,cpp,java,go,php,javascript,puppet,python,
					\rust,twig,xml,yml,perl,sql,html,css,
					\vim,markdown,coffee,ruby,matlab,tex
					\ autocmd BufWritePre <buffer>
					\ call StripTrailingWhitespace()

		" Close Vim if NERDTree is the last buffer
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
					\&& b:NERDTreeType == "primary") | q | endif

		autocmd BufWritePost *
			\   if expand('%') != '' && &buftype !~ 'nofile'
			\|      mkview!
			\|  endif

		autocmd BufRead *
			\   if expand('%') != '' && &buftype !~ 'nofile'
			\|      silent! loadview
			\|  endif
		autocmd BufWritePost * :silent! :syntax sync fromstart<cr>:redraw!<cr>
		autocmd GUIEnter * set visualbell t_vb=
	augroup END

	" Transparent editing of gpg encrypted files by Wouter Hanegraaff
	" https://gist.github.com/mrash/0f12560983a8c2888c5f
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
