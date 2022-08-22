local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table

local function config()
   local telescope = require('telescope')
    telescope.setup {defaults = {layout_strategy = 'flex',
                                 scroll_strategy = 'cycle'}}

    -- Load fzf and frecency extension after setup
    telescope.load_extension('fzf')
    telescope.load_extension('frecency') 
end

local function setup()
    -- Telescope key mappings
    normal_mode_set_keymap(
        leader_keymap_table(
        {['fb'] = "<cmd>Telescope buffers show_all_buffers=true sort_lastused=true<cr>",
         ['fs'] = "<cmd>Telescope git_files<cr>",
         ['ff'] = "<cmd>Telescope find_files<cr>",
         ['fg'] = "<cmd>Telescope live_grep<cr>",
         ['fh'] = "<cmd>Telescope help_tags<cr>",
        }),
        {silent=true})
end

return {config=config, setup=setup}
