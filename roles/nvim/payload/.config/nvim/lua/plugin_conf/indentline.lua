local g = vim.g

local function setup()
    g.indentLine_fileTypeExclude = {'tex', 'markdown', 'txt', 'startify', 'packer', 'help'}
    g.indentLine_bufTypeExclude = {'terminal'}
    vim.cmd [[highlight IndentBlanklineIndent guibg=#282A36 guifg=#424450 gui=nocombine]]  -- Fixed hidden cursor on indented whitespaces: The color should match the theme: The value of #282A26 is taken from dracula theme (currently active theme).
end
    
local function config()
    require("indent_blankline").setup {
        space_char_blankline = " ",
        space_char_highlight_list = {
            "IndentBlanklineIndent",
        },
        char_highlight_list = {
            "IndentBlanklineIndent",},
        show_current_context = true,
        show_current_context_start = true,
    }
end

return {config=config, setup=setup}

