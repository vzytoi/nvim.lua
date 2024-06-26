local THEMES = {}

local colors = u.colors.get()

THEMES.gruvbox = {
    normal = {
        a = { fg = colors.black, bg = colors.orange },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.black },
    },
    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.violet } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    }
}

THEMES.xcodedarkhc = {
    normal = {
        a = { fg = colors.black, bg = colors.pink },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.black },
    },
    insert = { a = { fg = colors.black, bg = colors.violet } },
    visual = { a = { fg = colors.black, bg = colors.green } },
    replace = { a = { fg = colors.black, bg = colors.orange } },
    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    }
}

THEMES.xcodedark = {
    normal = {
        a = { fg = colors.black, bg = colors.magenta },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white, bg = colors.grey },
    },
    insert = { a = { fg = colors.black, bg = colors.yellow } },

    visual = { a = { fg = colors.black, bg = colors.green } },
    replace = { a = { fg = colors.black, bg = colors.orange } },
    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    }
}

THEMES.github = "onelight"

return THEMES
