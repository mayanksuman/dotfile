-- ----------------------------------------
-- Commands
-- ----------------------------------------
local utils = require('utils')
local cmd, set_option, get_option = utils.cmd, utils.set_option, utils.get_option
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table

-- Set up commands for lua functions
cmd("command! QuickSpellingFix " ..
    "lua require('editting_functions').QuickSpellingFix()")
normal_mode_set_keymap(leader_keymap_table(
                        {z=':QuickSpellingFix'}))

cmd("command! StripTrailingWhitespace " ..
    "lua require('editting_functions').StripTrailingWhitespace()")
normal_mode_set_keymap(leader_keymap_table(
                        {stw=':StripTrailingWhitespace'}))

cmd("command! PasteWithPasteMode " ..
    "lua require('editting_functions').PasteWithPasteMode()")
normal_mode_set_keymap(leader_keymap_table(
                        {p=':PasteWithPasteMode'}))

normal_mode_set_keymap(
        {yl="lua require('editting_functions').YankLineWithoutNewline()"})

-- Silently execute an external command
-- No 'Press Any Key to Contiue BS'
-- from: http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
cmd("command! -nargs=1 SilentCmd execute ':silent !'.<q-args> execute ':redraw!'")

cmd("command! MakeTags !ctags -R .")

-- Fixes common typos
cmd("command! W w")
cmd("command! Wq wq")
cmd("command! Q q")
