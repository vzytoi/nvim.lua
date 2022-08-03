local COLORS = {}

COLORS.table = {
    gruvbox = {
        blue      = '#48898c',
        cyan      = '#79dac8',
        black     = '#000000',
        white     = '#c6c6c6',
        red       = '#fb4934',
        violet    = '#b16286',
        grey      = '#262626',
        orange    = "#e07016",
        green     = "#a0bb26",
        yellow    = "#f5bd3b",
        lightgrey = "#666666"
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
