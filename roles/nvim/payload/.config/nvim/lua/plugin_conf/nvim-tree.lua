local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table

local function setup()
    -- Nvim-Tree toggle key mappings
    normal_mode_set_keymap(leader_keymap_table({['td'] = "<cmd>NvimTreeToggle<cr>"}),
        {silent=true})
end

local function config()
    require'nvim-tree'.setup {
      disable_netrw = true,
      renderer = {
        highlight_git = true,
        highlight_opened_files = "icon",
        },
    }
end

return {config=config, setup=setup}
