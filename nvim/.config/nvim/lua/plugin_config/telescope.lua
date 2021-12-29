local telescope = require('telescope')
telescope.setup {defaults = {layout_strategy = 'flex', scroll_strategy = 'cycle'}}
telescope.load_extension('frecency')
telescope.load_extension('fzy_native')
