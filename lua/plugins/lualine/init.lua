local M = {}

M.load = {
    "hoob3rt/lualine.nvim",
    event = "ColorScheme",
    config = M.config
}

function M.config()
    local themes = require('plugins.lualine.themes')
    local components = require('plugins.lualine.components')

    local theme
    if themes[vim.g.colors_name] then
        theme = themes[vim.g.colors_name]
    else
        theme = "auto"
    end


    require('lualine').setup {
        options = {
            theme = theme,
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { components.mode },
            lualine_b = { components.runcode, components.branch },
            lualine_c = { components.searchcount, 'diagnostics' },
            lualine_x = components.harpoon,
            lualine_y = {
                components.lsp.on,
                components.lsp.off,
                components.format.on,
                components.format.off,
                components.ts.on,
                components.ts.off,
                components.spaces,
                components.filetype
            },
            lualine_z = {}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
        winbar = {}

    }
end

return M
