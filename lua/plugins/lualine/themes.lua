local M = {}

M.colors = {
    gruvbox = {
        blue   = '#48898c',
        cyan   = '#79dac8',
        black  = '#000000',
        white  = '#c6c6c6',
        red    = '#fb4934',
        violet = '#b16286',
        grey   = '#303030',
        orange = "#e07016",
        green  = "#b8bb26"
    }
}

M.gruvbox = {
    normal = {
        a = { fg = M.colors.gruvbox.black, bg = M.colors.gruvbox.orange },
        b = { fg = M.colors.gruvbox.white, bg = M.colors.gruvbox.grey },
        c = { fg = M.colors.gruvbox.white, bg = M.colors.gruvbox.black },
    },

    insert = { a = { fg = M.colors.gruvbox.black, bg = M.colors.gruvbox.blue } },
    visual = { a = { fg = M.colors.gruvbox.black, bg = M.colors.gruvbox.violet } },
    replace = { a = { fg = M.colors.gruvbox.black, bg = M.colors.gruvbox.red } },

    inactive = {
        a = { fg = M.colors.gruvbox.white, bg = M.colors.gruvbox.black },
        b = { fg = M.colors.gruvbox.white, bg = M.colors.gruvbox.black },
        c = { fg = M.colors.gruvbox.black, bg = M.colors.gruvbox.black },
    }
}

return M
