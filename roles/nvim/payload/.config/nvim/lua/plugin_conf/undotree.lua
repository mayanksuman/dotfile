local normal_mode_set_keymap = require('utils').normal_mode_set_keymap

local function config()
    vim.g.undotree_SetFocusWhenToggle = 1
    normal_mode_set_keymap({ ['<F5>'] = ':UndotreeToggle<cr>' }, { silent = true })
end

return { config = config }
