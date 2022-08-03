local THEMES = {}

local c = vim.colors.table.gruvbox

THEMES.gruvbox = {
    normal = {
        a = { fg = c.black, bg = c.orange },
        b = { fg = c.white, bg = c.grey },
        c = { fg = c.white, bg = c.black },
    },

    insert = { a = { fg = c.black, bg = c.blue } },
    visual = { a = { fg = c.black, bg = c.violet } },
    replace = { a = { fg = c.black, bg = c.red } },

    inactive = {
        a = { fg = c.white, bg = c.black },
        b = { fg = c.white, bg = c.black },
        c = { fg = c.black, bg = c.black },
    }
}

return THEMES
