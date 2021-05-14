local utils = require('utils')
local insert_mode_set_keymap = utils.insert_mode_set_keymap 
local select_mode_set_keymap = utils.select_mode_set_keymap 

local opts = {noremap = false, expr = true}
insert_mode_set_keymap({['<Tab>'] = [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
			['<S-Tab>'] = [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]}, opts)
select_mode_set_keymap({['<Tab>'] = [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
			['<S-Tab>'] = [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]}, opts)
