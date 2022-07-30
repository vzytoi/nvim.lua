local M = {}

local colors = {
    gruvbox = {
        blue   = '#48898c',
        cyan   = '#79dac8',
        black  = '#000000',
        white  = '#c6c6c6',
        red    = '#ff5189',
        violet = '#b16286',
        grey   = '#303030',
        orange = "#e07016",
    }
}

M.gruvbox = {
    normal = {
        a = { fg = colors.gruvbox.black, bg = colors.gruvbox.orange },
        b = { fg = colors.gruvbox.white, bg = colors.gruvbox.grey },
        c = { fg = colors.gruvbox.white, bg = colors.gruvbox.black },
    },

    insert = { a = { fg = colors.gruvbox.black, bg = colors.gruvbox.blue } },
    visual = { a = { fg = colors.gruvbox.black, bg = colors.gruvbox.violet } },
    replace = { a = { fg = colors.gruvbox.black, bg = colors.gruvbox.red } },

    inactive = {
        a = { fg = colors.gruvbox.white, bg = colors.gruvbox.black },
        b = { fg = colors.gruvbox.white, bg = colors.gruvbox.black },
        c = { fg = colors.gruvbox.black, bg = colors.gruvbox.black },
    },
}

return M
