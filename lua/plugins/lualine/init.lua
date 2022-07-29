local M = {}

local themes = require('plugins.lualine.themes')
local components = require('plugins.lualine.components')

function M.config()

    local cs = vim.g.colors_name

    require('lualine').setup {
        options = {
            theme = themes[cs] or cs,
            component_separators = '|',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                { 'mode', separator = { left = '' }, right_padding = 2 },
            },
            lualine_b = {
                components.filename,
            },
            lualine_c = {
                'fileformat',
                'diagnostics',
            },
            lualine_x = {},
            lualine_y = {
                {
                    'diff',
                    symbols = {
                        added = "",
                        modified = "",
                        removed = ""
                    }
                },
                components.lsp,
                components.progression,
                {
                    'filetype',
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                    },
                    icon = { align = 'right' }
                },
            },
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
    }

end

return M
