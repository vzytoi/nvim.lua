local colors = {
    white        = '#DEDEDE',
    orange       = '#CE4F00',
    yellow       = '#BCA409',
    blue         = '#7A8FBA',
    green        = '#45912B',
    darkgray     = '#242424',
    lightgray    = '#303030',
    pink         = '#BE65D4'
}

-- LuaFormatter on
return {
    normal = {
        a = {bg = colors.green, fg = colors.white, gui = 'bold'},
        b = {bg = colors.lightgray, fg = colors.white},
        c = {bg = colors.darkgray, fg = colors.white}
    },
    insert = {
        a = {bg = colors.blue, fg = colors.white, gui = 'bold'},
        b = {bg = colors.lightgray, fg = colors.white},
        c = {bg = colors.darkgray, fg = colors.white}
    },
    visual = {
        a = {bg = colors.yellow, fg = colors.white, gui = 'bold'},
        b = {bg = colors.lightgray, fg = colors.white},
        c = {bg = colors.darkgray, fg = colors.white}
    },
    replace = {
        a = {bg = colors.orange, fg = colors.white, gui = 'bold'},
        b = {bg = colors.lightgray, fg = colors.white},
        c = {bg = colors.darkgray, fg = colors.white}
    },
    command = {
        a = {bg = colors.pink, fg = colors.white, gui = 'bold'},
        b = {bg = colors.lightgray, fg = colors.white},
        c = {bg = colors.darkgray, fg = colors.white}
    },
    inactive = {
        a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.darkgray, fg = colors.gray},
        c = {bg = colors.darkgray, fg = colors.gray}
    }
}
