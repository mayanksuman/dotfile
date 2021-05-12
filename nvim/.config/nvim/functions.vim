" ----------------------------------------
" Functions
" ----------------------------------------

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
" Strip Trailing White Space
" From http://vimbits.com/bits/377
" ---------------
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
" Paste using Paste Mode : Keeps indentation in source.
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
" Show all leader keybindings.
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

" ---------------
" Copy all matched search result (to be called after a search).
" Adapted from https://vim.fandom.com/wiki/Copy_search_matches
" ---------------
function! CopyMatches(reg)
	let hits = []
	%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" ---------------
" Copy the current line without newline character at the end.
" ---------------
function! YankLineWithoutNewline()
	let l = line(".")
	let c = col(".")
	normal ^y$
	" Clean up: restore previous search history, and cursor position
	call cursor(l, c)
endfunction

nnoremap <silent>yl :call YankLineWithoutNewline()<CR>

" ---------------
" Show the word frequency of the current buffer in a split.
" from: http://vim.wikia.com/wiki/Word_frequency_statistics_for_a_file
" ---------------
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
