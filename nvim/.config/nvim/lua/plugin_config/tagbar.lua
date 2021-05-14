local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap

normal_mode_set_keymap({['<F8>'] = ':TagbarToggle<CR>'})
