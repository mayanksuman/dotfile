local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn
local join_path = utils.join_path

vim.g.UltiSnipsSnippetDirectories={join_path(fn.stdpath('config'), "MyUltiSnippets"),"MyUltiSnippets"}
vim.g.UltiSnipsExpandTrigger='<C-e>'
vim.g.UltiSnipsJumpForwardTrigger='<C-j>'
vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'


-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit="vertical"
