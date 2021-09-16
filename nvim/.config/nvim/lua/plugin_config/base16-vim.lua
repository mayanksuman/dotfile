local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn

if fn.filereadable(fn.expand("~/.vimrc_background")) == 1 then
  cmd('source ~/.vimrc_background')
end
