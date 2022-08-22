local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table

local function config()
    require("toggleterm").setup()
    
    -- ToggleTerm key mappings
    normal_mode_set_keymap(leader_keymap_table({['tt'] = "<cmd>ToggleTerm<cr>"}),
        {silent=true})
end

return {config=config}
