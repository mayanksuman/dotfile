local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table

-- colors for active , inactive uffer tabs
require "bufferline".setup {
    options = {
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        enforce_regular_tabs = true,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin"
    },
}

--command that adds new buffer and moves to it
vim.api.nvim_command "com -nargs=? -complete=file_in_path New badd <args> | blast"
normal_mode_set_keymap({['<S-n>'] = ":New ",                           -- Add new buffer
            ['<S-d>'] = [[<Cmd>bdelete<CR>]],              -- Removing a buffer
            ['<S-l>'] = [[<Cmd>BufferLineCycleNext<CR>]],  -- Move to next tab
            ['<S-h>'] = [[<Cmd>BufferLineCyclePrev<CR>]],  -- Move to previous tab
            }, {silent=true})

-- buffer shortcuts
buffer_keys = {}
for i = 1, 9 do
    buffer_keys[''..i] = [[<Cmd>BufferLineGoToBuffer ]]..i..'<CR>'
end
normal_mode_set_keymap(leader_keymap_table(buffer_keys), {silent=true, noremap=true})
