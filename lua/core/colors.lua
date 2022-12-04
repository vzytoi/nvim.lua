local M = {}

local c = u.colors.get()

local raw = {
    all = {},
    gruvbox = {
        LineNr = { fg = "#6B6B6B" },
        CursorLine = { bg = c.darkgrey },
        CursorLineNR = { fg = c.white, bold = true },

        VertSplit = { fg = "#6B6B6B" },
        LspReferenceText = { bold = true },
        LspReferenceRead = { bold = true },
        LspReferenceWrite = { bold = true },
        Normal = { bg = c.black },
        NonText = { bg = c.black, fg = c.black },
        StatusLine = { bg = c.black },
        NormalFloat = { bg = c.black, fg = c.white },
        Visual = { bg = c.grey },

        DiagnosticError = { fg = c.red, bold = true },
        DiagnosticWarn = { fg = c.orange, bold = true },
        DiagnosticInfo = { fg = c.green, bold = true },
        DiagnosticHint = { fg = c.blue, bold = true },

        GruvboxGreenSign = { bg = c.black, fg = c.green },

        SignColumn = { bg = c.black },

        TabLine = { bg = c.black },
        TabLineSel = { bg = c.black, fg = c.blue, bold = true },
        TabLineFill = { bg = c.black },

        SepOn = { fg = c.blue },
        SepOff = { fg = c.grey },

        TextOn = { fg = c.white, bold = true },
        TextOff = { fg = c.lightgrey },

        RunCodeOk = { fg = c.green },
        RunCodeError = { fg = c.red },
        RunCodeInfo = { fg = c.blue },

        CmpItemAbbr = { fg = "#a6a6a6" },
        CmpItemAbbrMatch = { fg = c.white, bold = true },

    },
    xcodedarkhc = {
        Normal = { bg = c.black },
        NonText = { bg = c.black, fg = c.black },
        EndOfBuffer = { bg = c.black, fg = c.black },

        TabLine = { bg = c.black },
        TabLineSel = { bg = c.black, bold = true },
        TabLineFill = { bg = c.darkerblack },

        -- TextOn = { bg = c.black, fg = c.white, bold = true },
        TextOff = { bg = c.black, fg = c.lightgrey },

        SepOn = { fg = c.pink },
        SepOff = { fg = c.lightgrey },

        StatusLine = { bg = c.black },

        LspReferenceText = { bold = true },
        LspReferenceRead = { bold = true },
        LspReferenceWrite = { bold = true },

        CursorLineNr = { bold = true, fg = c.white },

        RunCodeNormal = { bg = c.darkerblack },
        RunCodeOk     = { fg = c.green, bold = true },
        RunCodeError  = { fg = c.red, bold = true },
        RunCodeInfo   = { fg = c.blue, bold = true },

        NvimTreeNormal           = { bg = c.darkerblack },
        NvimTreeEndOfBuffer      = { fg = c.darkerblack, bg = c.darkerblack },
        NvimTreeFolderName       = { fg = c.white },
        NvimTreeOpenedFolderName = { fg = c.white },
        NvimTreeFolderIcon       = { fg = c.darkgrey },
        NvimTreeWinSeparator     = { bg = c.black },
        NvimTreeOpenedFile       = { fg = c.pink },
        NvimTreeIndentMarker     = { fg = c.darkgrey },

        Pmenu = { bg = c.black },
        FloatBorder = { bg = c.black },
        NormalFloat = { bg = c.black },

        GlancePreviewNormal = { bg = c.grey },
        GlanceListNormal = { bg = c.grey }
    }
}

local apply = function(name, args)
    nvim.set_hl(0, name, args)
end

local undeep = function(v)
    for k, _ in pairs(v[2]) do
        v[2][k] = vim.tbl_extend('keep', v[2][k], v[1])
    end

    return v[2]
end

local filter_colors = function(hi)
    local o = {}

    for k, _ in pairs(hi) do
        if k == vim.g.colors_name or k == "all" then
            o = vim.tbl_extend('keep', o, hi[k])
        end
    end

    return o
end

M.config = function()
    require("plugins.lualine").config()

    local o = filter_colors(raw)

    for k, _ in pairs(o) do
        if k == "_" then
            o = vim.tbl_extend('keep', undeep(o[k]), o)
        end
    end

    for k, v in pairs(o) do
        if k ~= "_" then
            apply(k, v)
        end
    end

    vim.fn.sign_define("DiagnosticSignError",
        { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignWarn",
        { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "DiagnosticWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
        { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "DiagnosticHint" })

end

return M
