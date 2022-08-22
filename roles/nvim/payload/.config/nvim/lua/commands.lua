-- ----------------------------------------
-- Commands
-- ----------------------------------------
local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table
local set_command = utils.set_command

-- Set up commands for lua functions
set_command({
    QuickSpellingFix = "lua require('editting_functions').QuickSpellingFix()",
    StripTrailingWhitespace = "lua require('editting_functions').StripTrailingWhitespace()",
    PasteWithPasteMode = "lua require('editting_functions').PasteWithPasteMode()",
    YankLineWithoutNewline = "lua require('editting_functions').YankLineWithoutNewline()"
})

normal_mode_set_keymap(leader_keymap_table(
                        {z  =':QuickSpellingFix<cr>',
                         stw=':StripTrailingWhitespace<cr>',
                         p  =':PasteWithPasteMode<cr>',
                         yl =':YankLineWithoutNewline<cr>',
                        }))


-- Silently execute any command
-- No 'Press Any Key to Contiue BS'
-- from: http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
set_command({Silent="execute 'silent <args>'| execute redraw!"}, {nargs='+', bang=true})

set_command({MakeTags="!ctags -R ."}, {bang=true})

-- Fixes common typos
set_command({W='w', Wq='wq', Q='q'}, {bang=true})
