--[==[

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

]==]
