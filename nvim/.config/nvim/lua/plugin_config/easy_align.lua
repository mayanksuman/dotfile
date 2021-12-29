local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local visual_mode_set_keymap = utils.visual_mode_set_keymap

-- Keybindings
local options = {silent = true, noremap = false}
normal_mode_set_keymap({ga='<Plug>(EasyAlign)'}, options)
visual_mode_set_keymap({ga='<Plug>(EasyAlign)'}, options)
