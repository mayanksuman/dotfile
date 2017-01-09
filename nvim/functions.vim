" ----------------------------------------
" Functions
" ----------------------------------------


" ---------------
" Return Cursor Position in previously editted files
" ---------------
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:ms_vim_no_restore_cursor = 1
if !exists('g:ms_vim_no_restore_cursor')
	function! ResCur()
		if line("'\"") <= line("$")
			silent! normal! g`"
			return 1
		endif
	endfunction
endif

" ---------------
" Quick spelling fix (first item in z= list)
" ---------------
function! QuickSpellingFix()
	if &spell
		normal 1z=
	else
		" Enable spelling mode and do the correction
		set spell
		normal 1z=
		set nospell
	endif
endfunction

command! QuickSpellingFix call QuickSpellingFix()
nnoremap <silent> <leader>z :QuickSpellingFix<CR>

" ---------------
" Convert Ruby 1.8 hash rockets to 1.9 JSON style hashes.
" From: http://git.io/cxmJDw
" Note: Defaults to the entire file unless in visual mode.
" ---------------
command! -bar -range=% NotRocket execute
			\'<line1>,<line2>s/:\(\w\+\)\s*=>/\1:/e'
			\ . (&gdefault ? '' : 'g')

" ------------------------------------
" Convert .should rspec syntax to expect.
" From: https://coderwall.com/p/o2oyrg
" ------------------------------------
command! -bar -range=% Expect execute
			\'<line1>,<line2>s/\(\S\+\).should\(\s\+\)==\s*\(.\+\)' .
			\'/expect(\1).to\2eq(\3)/e' .
			\(&gdefault ? '' : 'g')

" ---------------
" Strip Trailing White Space
" ---------------
" From http://vimbits.com/bits/377
" Preserves/Saves the state, executes a command, and returns to the saved state
function! StripTrailingWhitespace()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" do the business:
	%s/\s\+$//e
	" clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

command! StripTrailingWhitespace :call StripTrailingWhitespace()<CR>
nnoremap <silent> <leader>stw :silent! StripTrailingWhitespace()<CR>

" ---------------
" Paste using Paste Mode
"
" Keeps indentation in source.
" ---------------
function! PasteWithPasteMode()
	if &paste
		normal p
	else
		" Enable paste mode and paste the text, then disable paste mode.
		set paste
		normal p
		set nopaste
	endif
endfunction

command! PasteWithPasteMode call PasteWithPasteMode()
nnoremap <silent> <leader>p :PasteWithPasteMode<CR>

" ---------------
" Write Buffer if Necessary
"
" Writes the current buffer if it's needed, unless we're the in QuickFix mode.
" ---------------

function WriteBufferIfNecessary()
	if &modified && !&readonly
		:write
	endif
endfunction
command! WriteBufferIfNecessary call WriteBufferIfNecessary()

function CRWriteIfNecessary()
	if &filetype == "qf"
		" Execute a normal enter when in Quickfix list.
		execute "normal! \<enter>"
	else
		WriteBufferIfNecessary
	endif
endfunction

" Clear the search buffer when hitting return
" Idea for MapCR from http://git.io/pt8kjA
function! MapCR()
	nnoremap <silent> <enter> :call CRWriteIfNecessary()<CR>
endfunction
call MapCR()

" ---------------
" Make a scratch buffer with all of the leader keybindings.
"
" Adapted from http://ctoomey.com/posts/an-incremental-approach-to-vim/
" ---------------
function! ListLeaders()
	silent! redir @b
	silent! nmap <LEADER>
	silent! redir END
	silent! new
	silent! set buftype=nofile
	silent! set bufhidden=hide
	silent! setlocal noswapfile
	silent! put! b
	silent! g/^s*$/d
	silent! %s/^.*,//
	silent! normal ggVg
	silent! sort
	silent! let lines = getline(1,"$")
	silent! normal <esc>
endfunction

command! ListLeaders :call ListLeaders()

function! CopyMatches(reg)
	let hits = []
	%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

function! YankLineWithoutNewline()
	let l = line(".")
	let c = col(".")
	normal ^y$
	" Clean up: restore previous search history, and cursor position
	call cursor(l, c)
endfunction

nnoremap <silent>yl :call YankLineWithoutNewline()<CR>

" Show the word frequency of the current buffer in a split.
" from: http://vim.wikia.com/wiki/Word_frequency_statistics_for_a_file
function! WordFrequency() range
	let all = split(join(getline(a:firstline, a:lastline)), '\A\+')
	let frequencies = {}
	for word in all
		let frequencies[word] = get(frequencies, word, 0) + 1
	endfor
	new
	setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20
	for [key,value] in items(frequencies)
		call append('$', key."\t".value)
	endfor
	sort i
endfunction
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()

" ---------------
" Sort attributes inside <> in html.
" E.g.
" <div
"   b="1"
"   a="1"
"   c="1"
" />
"
" becomes
"
" <div
"   a="1"
"   b="1"
"   c="1"
" />
" ---------------
function! SortAttributes()
	normal vi>kojV
	:'<,'>sort
endfunction

command! SortAttributes call SortAttributes()
nnoremap <silent> <leader>sa :SortAttributes<CR>

" ---------------
" Sort values inside a curl block
" ---------------
function! SortBlock()
	normal vi}
	:'<,'>sort
endfunction

command! SortBlock call SortBlock()
nnoremap <silent> <leader>sb :SortBlock<CR>


" ---------------
" Better Folded line number
" http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" ---------------
function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()
