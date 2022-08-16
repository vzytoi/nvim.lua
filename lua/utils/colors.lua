local COLORS = {}

COLORS.table = {
    gruvbox = {
        blue      = '#48898c',
        cyan      = '#79dac8',
        black     = "#000000",
        white     = '#c6c6c6',
        red       = '#fb4934',
        violet    = '#b16286',
        orange    = "#e07016",
        green     = "#a0bb26",
        yellow    = "#f5bd3b",
        lightgrey = "#666666",
        grey      = '#262626',
        darkgrey  = "#191919"
    },
    xcodedarkhc = {
        black = "#1f1f24",
        orange = "#ff8a7a",
        green = "#83c9bc",
        yellow = "#d9c668",
        blue = "#4ec4e6",
        pink = "#ff85b8",
        white = "#ffffff",
        grey = "#262626"
    }
}

COLORS.default = {
    blue = "#0000FF",
    red = "#FF0000",
    black = "#000000",
    white = "#ffffff",
    orange = "#FFA500",
    violet = "#EE82EE",
    green = "#008000"
}

COLORS.get = function()
    return COLORS.table[vim.g.colors_name] or COLORS.default
end

return COLORS
