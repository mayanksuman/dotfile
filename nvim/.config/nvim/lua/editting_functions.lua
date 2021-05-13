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
-- Show all leader keybindings.
-- Adapted from http://ctoomey.com/posts/an-incremental-approach-to-vim/
-- ---------------
local function ListLeaders()
    cmd([[silent! redir @b
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
	silent! normal <esc>]])
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

--[==[
-- ---------------
-- Show the word frequency of the current buffer in a split.
-- from: http://vim.wikia.com/wiki/Word_frequency_statistics_for_a_file
-- ---------------
local function WordFrequency()
	local all = fn.split(fn.join(line), [[\A\+]])
	local frequencies = frequencies or {}
	for word in all do
		frequencies[word] = frequencies[word] + 1
	end
	cmd([[new
	setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20]])
    for key,value in pairs(frequencies) do
		fn.append('$', key .. "\t" .. value)
	end
	cmd('sort i')
end
]==]





return {QuickSpellingFix=QuickSpellingFix,
StripTrailingWhitespace=StripTrailingWhitespace,
PasteWithPasteMode=PasteWithPasteMode,
ListLeaders=ListLeaders,
YankLineWithoutNewline = YankLineWithoutNewline,
-- WordFrequency=WordFrequency,
}
