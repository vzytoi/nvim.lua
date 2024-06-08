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
        darkerblack = "#0f0f0f",
        black = "#131314",
        orange = "#181819",
        green = "#83c979",
        yellow = "#d9c668",
        blue = "#4ec4e6",
        pink = "#ff85b8",
        white = "#ffffff",
        grey = "#262626",
        lightgrey = "#bfbfbf",
        violet = "#cda1ff",
        darkgrey = "#666666",
        red = "#FF0000"
    },
    github = {
        white = "#F8F8FF",
        grey = "#a8a8a8",
        red = "#aa3636",
        blue = "#566795",
        pink = "#ab3e91",
        green = "#6abc79"
    },
    xcodedark = {
        black      = "#414453",
        red        = "#ff8170",
        green      = "#78c2b3",
        yellow     = "#d9c97c",
        blue       = "#4eb0cc",
        magenta    = "#ff7ab2",
        cyan       = "#b281eb",
        white      = "#dfdfe0",
        foreground = "#dfdfe0",
        background = " #292a30",
    }
}

COLORS.default = {
    blue = "#0000FF",
    red = "#FF0000",
    black = "#000000",
    white = "#0000ff",
    orange = "#FFA500",
    violet = "#EE82EE",
    green = "#008000"
}

COLORS.get = function()
    return COLORS.table[vim.g.colors_name] or COLORS.default
end

return COLORS
