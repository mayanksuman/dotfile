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
		autocmd FileType c,cpp,java,go,php,javascript,puppet,python,
					\rust,twig,xml,yml,perl,sql,html,css,
					\vim,markdown,coffee,ruby,matlab
					\ autocmd BufWritePre <buffer>
					\ if !exists('g:ms_vim_keep_trailing_whitespace')
					\| call StripTrailingWhitespace() | endif


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


	" Transparent editing of gpg encrypted files.
	" By Wouter Hanegraaff
	augroup encrypted
		au!

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


	"LaTeX commands, from JG
	augroup texcmds
		autocmd!
		"http://learnvimscriptthehardway.stevelosh.com/chapters/44.html
		au BufNewFile,BufRead *.tex set filetype=tex
		"try <Esc>:set filetype?
		"autocmd FileType tex map <buffer> <F7> :silent !skim: %:r.pdf  &> /dev/null &<CR>:redraw!<CR>
		"autocmd FileType tex map <buffer> <F5>  :!open /Applications/Skim.app: %:r.pdf  &> /dev/null &<CR>:redraw!<CR>
		autocmd FileType tex map <buffer> <F5> :w<CR>:!xelatex % <CR><CR>
		autocmd FileType tex map <buffer> <F6> :w<CR>:!pdflatex % <CR><CR>
		autocmd FileType tex map <buffer> <F8> :w<CR>:!bibtex %:r.aux <CR><CR>
		autocmd FileType tex setlocal spell spelllang=en_us

		"http://stackoverflow.com/questions/5054128/repeating-characters-in-vim-insert-mode
		"autocmd FileType tex map <buffer> \sep<CR> i%-<Esc>y1l80pa%<Esc>0o<Esc>
		"     autocmd FileType tex map <buffer> \sep<CR> i%%<C-o>:norm 80ia<CR><Esc>0o<Esc>
		autocmd FileType tex map <buffer> \sep<CR> i%%<C-o>80i-<Esc>0o<Esc>
		autocmd FileType tex inoremap <C-l> <Esc>la
		autocmd FileType tex inoremap <C-h> <Esc>ha
		"autocmd FileType tex inoremap <C-l> <Esc>lli

		"need to create a file main.tex.latexmaster, containing one character
		autocmd FileType tex map <buffer> <F7>  :call CompileMasterFile() <CR><CR>


		"Ideas for creating these functions from:
		"http://vim-latex.sourceforge.net/documentation/latex-suite/latex-master-file.html#Tex_MainFileExpression
		"and
		"http://vi.stackexchange.com/questions/2408/vimscript-save-file
		"and
		"http://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim
		function! CompileMasterFile()
			let mainfilename = GetMasterFileName()
			let mainauxfilename = GetMasterFileNameAux()
			if mainfilename != ''
				"save and compile with pdflatex
				:w
				execute ':silent !pdflatex ' mainfilename
				execute ':silent !bibtex ' mainauxfilename
				execute ':silent !bibtex ' mainauxfilename
				execute ':silent !pdflatex ' mainfilename
				execute '!pdflatex ' mainfilename
			else
				"if no master file found, show message
				echom "No master file found (e.g. myfile.tex.latexmaster)"
			endif
		endfunction

		"we indicate the name of mymain.tex by creating a file mymain.tex.latexmaster,
		"which can be empty (or just contain a blank line
		function! GetMasterFileName()
			if glob('*.latexmaster') != ''
				"this just removes the '.latexmaster' bit
				return split(glob('*.latexmaster'), ".latexmaster")[0]
			else
				return ''
			endif
		endfunction

		"in order for bibtex to work, we need the 'mymain.aux' filename
		"this seems to be one way to obtain it
		function! GetMasterFileNameAux()
			if glob('*.latexmaster') != ''
				"this removes the 'tex.latexmaster' bit and replaces it with 'aux'
				return join([split(glob('*.latexmaster'), ".tex.latexmaster")[0], "aux"], ".")
			else
				return ''
			endif
		endfunction
	augroup END

endif
