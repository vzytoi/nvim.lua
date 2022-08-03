local M = {}

local themes = require('plugins.lualine.themes')
local components = require('plugins.lualine.components')

function M.config()

    local cs = vim.g.colors_name

    require('lualine').setup {
        options = {
            theme = themes[cs] or cs,
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { components.mode },
            lualine_b = { components.branch },
            lualine_c = { 'diagnostics', },
            lualine_x = {},
            lualine_y = {
                components.diff,
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
