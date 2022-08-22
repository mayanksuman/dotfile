local function config()
    local g = vim.g
    g.vimtex_compiler_progname = 'latexmk'
    g.vimtex_complete_recursive_bib = 1
    g.vimtex_complete_enabled = 1
    g.vimtex_quickfix_method = 'pplatex'
    g.tex_conceal = ''
    g.vimtex_quickfix_mode = 0
    g.vimtex_view_forward_search_on_start = 0
    g.vimtex_view_general_viewer = 'zathura'
    g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
end

return {config=config}
