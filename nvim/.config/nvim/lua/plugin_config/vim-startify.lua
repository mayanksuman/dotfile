local utils = require("utils")
local cmd, fn = utils.cmd, utils.fn
local g = vim.g

g.startify_list_order = {{'   Last modified'}, 'dir', {'   Recent'}, 'files',}
g.startify_skiplist = {'COMMIT_EDITMSG', fn.expand('$VIMRUNTIME') ..'/doc',
                        'bundle/.*/doc',}
g.startify_files_number = 15
g.startify_custom_indices = {'a', 's', 'd', 'g', 'l'}
g.startify_change_to_dir = 1

cmd([[hi StartifyBracket ctermfg=240
hi StartifyFooter  ctermfg=111
hi StartifyHeader  ctermfg=203
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240]]
)

-- Keep NERDTree from opening a split when startify is open
cmd("autocmd FileType startify setlocal buftype=")

g.startify_recursive_dir = 1

-- Faster Start
g.signify_update_on_bufenter = 0
g.signify_sign_overwrite = 0

-- Only use git
g.signify_vcs_list = {'git'}
