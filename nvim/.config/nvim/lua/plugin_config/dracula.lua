vim.cmd('colorscheme dracula')

require('lualine').setup {
  options = {
    theme = 'dracula',
    section_separators = '',
    component_separators = '|'
  }
}