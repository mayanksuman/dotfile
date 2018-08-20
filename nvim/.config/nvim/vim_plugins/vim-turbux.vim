if exists('g:vim_plug_installing_plugins')
  Plug 'jgdavey/vim-turbux' "helps in running rspec and cucumber test.
  Plug 'pitluga/vimux-nose-test' "help in running python nose test
  finish
endif

let g:no_turbux_mappings = 1
map <leader>X <Plug>SendTestToTmux
map <leader>x <Plug>SendFocusedTestToTmux
let g:turbux_command_rspec = 'spring rspec'
let g:turbux_command_cucumber = 'spring cucumber'
