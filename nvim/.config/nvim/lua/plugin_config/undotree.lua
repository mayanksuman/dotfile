local normal_mode_set_keymap = require('utils').normal_mode_set_keymap

vim.g.undotree_SetFocusWhenToggle = 1
normal_mode_set_keymap({['<F5>'] = ':UndotreeToggle<cr>'})
