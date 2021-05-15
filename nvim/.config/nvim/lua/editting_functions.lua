-- ----------------------------------------
-- Functions
-- ----------------------------------------
local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn
local set_option, get_option = utils.set_option, utils.get_option

-- ---------------
-- Quick spelling fix (first item in z= list)
-- ---------------
local function QuickSpellingFix()
	if get_option('w', 'spell') then
		cmd('normal 1z=')
	else
		-- Enable spelling mode and do the correction
		set_option('w', 'spell', true)
		cmd('normal 1z=')
		set_option('w', 'spell', false)
	end
end

-- ---------------
-- Strip Trailing White Space
-- From http://vimbits.com/bits/377
-- ---------------
local function StripTrailingWhitespace()
	-- Preparation: save last search, and cursor position.
	local s = fn.getreg('/')
	local l = fn.line(".")
	local c = fn.col(".")
	-- do the business:
	cmd([[%s/\s\+$//e]])
	-- clean up: restore previous search history, and cursor position
	fn.setreg('/', s)
	fn.cursor(l, c)
end


-- ---------------
-- Paste using Paste Mode : Keeps indentation in source.
-- ---------------
local function PasteWithPasteMode()
	if get_option('o', 'paste') then
		cmd('normal p')
	else
		-- Enable paste mode and paste the text, then disable paste mode.
		set_option('o', 'paste', true)
		cmd('normal p')
		set_option('o', 'paste', false)
	end
end


-- ---------------
-- Copy the current line without newline character at the end.
-- ---------------
local function YankLineWithoutNewline()
	local l = fn.line(".")
	local c = fn.col(".")
	cmd('normal ^y$')
	-- Clean up: restore previous search history, and cursor position
	fn.cursor(l, c)
end


-- ---------------
-- Copy all matched search result (to be called after a search).
-- Adapted from https://vim.fandom.com/wiki/Copy_search_matches
-- ---------------
cmd([[function! CopyMatches(reg)
	let hits = []
	%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)]])


return {QuickSpellingFix=QuickSpellingFix,
StripTrailingWhitespace=StripTrailingWhitespace,
PasteWithPasteMode=PasteWithPasteMode,
ListLeaders=ListLeaders,
YankLineWithoutNewline = YankLineWithoutNewline,
}
