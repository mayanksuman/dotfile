-- ----------------------------------------
-- Functions
-- ----------------------------------------
local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn

-- ---------------
-- Quick spelling fix (first item in z= list)
-- ---------------
local function QuickSpellingFix()
    if vim.opt.spell:get() then
        cmd('normal 1z=')
    else
        -- Enable spelling mode and do the correction
        vim.opt.spell = true
        cmd('normal 1z=')
        vim.opt.spell = false
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
        ListLeaders=ListLeaders,
        YankLineWithoutNewline = YankLineWithoutNewline,
}
