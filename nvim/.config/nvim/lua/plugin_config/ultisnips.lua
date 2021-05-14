local utils = require('utils')
local cmd = utils.cmd
local join_path = utils.join_path

vim.g.UltiSnipsSnippetDirectories={join_path(config_file_location, "MyUltiSnippets"),"MyUltiSnippets"}
vim.g.UltiSnipsExpandTrigger='<C-e>'
vim.g.UltiSnipsJumpForwardTrigger='<C-j>'
vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'


-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit="vertical"
