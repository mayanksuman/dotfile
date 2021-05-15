local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap

local direct_shortcut = {['<leader>l'] = ":BufferLast<CR>"}
for i=1, 9 do
    direct_shortcut['<leader>'..i] = ":BufferGoto " .. i .. "<CR>"
end

normal_mode_set_keymap(direct_shortcut)
normal_mode_set_keymap({['<leader>c'] = ":BufferClose<CR>",
                        ['<leader>s'] = ":BufferPick<CR>",
                        ['gt'] = ":BufferNext<CR>",
                        ['gT'] = ":BufferPrevious<CR>",
                    })

