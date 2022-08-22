local function config()
    require('lualine').setup {
      options = {
        theme = 'dracula',
        section_separators = '',
        component_separators = '|'
      }
    }
end

return {config = config}
