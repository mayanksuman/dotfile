local utils = require('utils')
local insert_mode_set_keymap = utils.insert_mode_set_keymap

vim.g.loaded_compe_treesitter = true
vim.g.loaded_compe_snippets_nvim = true
vim.g.loaded_compe_spell = true
vim.g.loaded_compe_tags = true
vim.g.loaded_compe_ultisnips = true
vim.g.loaded_compe_vim_lsc = true
vim.g.loaded_compe_vim_lsp = true
vim.o.completeopt = "menuone,noselect"

require('compe').setup {
  enabled = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  source = {path = true, buffer = true, nvim_lsp = true, nvim_lua = true, vsnip = true, ultisnips = true}
}

local opts = {noremap=true, silent = true, expr = true}
insert_mode_set_keymap({['<c-c>'] = [[compe#complete()]],
                        ['<cr>'] = [[compe#confirm('<cr>')]], 
                        ['<c-e>'] = [[compe#close('<c-e>')]]}, opts)
