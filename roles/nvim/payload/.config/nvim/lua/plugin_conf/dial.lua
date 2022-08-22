local utils = require('utils')
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local visualselect_mode_set_keymap = utils.visualselect_mode_set_keymap

local function config()
    -- Dial key mappings
    normal_mode_set_keymap(
        {['<C-a>'] = "<Plug>(dial-increment)",
         ['<C-x>'] = "<Plug>(dial-decrement)",
        },
        {silent=true})
    
    visualselect_mode_set_keymap(
        {['<C-a>'] = "<Plug>(dial-increment)",
         ['<C-x>'] = "<Plug>(dial-decrement)",
         ['g<C-a>'] = "<Plug>(dial-increment-additional)",
         ['g<C-x>'] = "<Plug>(dial-decrement-additional)",
        },
        {silent=true})
end

return {config=config}
