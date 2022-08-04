local TL = {}

local devicons = require('nvim-web-devicons')
local ic = 0

TL.icon = function(bufnr)

    local fn = TL.filename(bufnr)

    local icon, color = devicons.get_icon_color(
        fn,
        vim.fn.getbufvar(bufnr, "&filetype"),
        { default = true }
    )

    ic = ic + 1
    vim.cmd("hi Icon" .. ic .. " guifg=" .. color)

    return icon, "%#Icon" .. ic .. "#"
end

TL.filename = function(bufnr)
    return vim.fn.bufname(bufnr) == ""
        and "Empty" or vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
end

TL.bufnr = function(v)
    return vim.fn.tabpagebuflist(v)[
        vim.fn.tabpagewinnr(v)
        ]
end

TL.color = {
    sep = function(v)
        return "%#Sep" .. (v == vim.fn.tabpagenr() and "On#" or "Off#")
    end,
    txt = function(v)
        return "%#Text" .. (v == vim.fn.tabpagenr() and "On#" or "Off#")
    end
}

TL.get = function()

    local rangetabs = vim.fn.range(
        1, vim.fn.tabpagenr('$')
    )

    local tabs = {}

    for _, v in pairs(rangetabs) do

        local tab = ""

        tab = tab .. string.format(
            "%%%dT%s",
            v, v == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
        )

        local bufnr = TL.bufnr(v)
        local icon, color = TL.icon(bufnr)

        tab = tab ..
            TL.color.sep(v) ..
            "▎  " ..
            color ..
            icon ..
            " " ..
            TL.color.txt(v) ..
            " " ..
            TL.filename(bufnr) ..
            "   "

        table.insert(tabs, tab)

    end

    return table.concat(tabs, "")

end

return TL
