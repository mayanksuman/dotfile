local normal_mode_set_keymap = require('utils').normal_mode_set_keymap

-- Navigate buffers and repos
normal_mode_set_keymap({['<c-a>'] = "<cmd>Telescope buffers show_all_buffers=true sort_lastused=true<cr>",
                        ['<c-s>'] = "<cmd>Telescope git_files<cr>",
                        ['<c-d>'] = "<cmd>Telescope find_files<cr>",
                        ['<c-g>'] = "<cmd>Telescope live_grep<cr>",},
                        {silent=true})
