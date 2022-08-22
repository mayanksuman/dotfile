local utils = require('utils')

local function config()
    utils.normal_mode_set_keymap({['<F8>'] = ':TagbarToggle<CR>'})
end

return {config=config}
