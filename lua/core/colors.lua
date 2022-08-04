local M = {}

local c = vim.colors.table.gruvbox

local raw = {
    all = {
        LineNr = { fg = "#6B6B6B" },
        VertSplit = { fg = "#6B6B6B" },
        LspReferenceText = { bold = true },
        LspReferenceRead = { bold = true },
        LspReferenceWrite = { bold = true },
        Normal = { bg = vim.colors.default.black },
        NonText = { bg = vim.colors.default.black },
        StatusLine = { bg = vim.colors.default.black },
    },
    spacecamp = {
        CursorLineNR = { fg = c.violet, bold = true }
    },
    gruvbox = {
        NormalFloat = { bg = c.black, fg = c.white },
        Visual = { bg = c.grey },
        CursorLineNR = { fg = c.violet, bold = true },

        DiagnosticError = { fg = c.red, bold = true },
        DiagnosticWarn = { fg = c.orange, bold = true },
        DiagnosticInfo = { fg = c.green, bold = true },
        DiagnosticHint = { fg = c.blue, bold = true },

        GitSignsAdd = { fg = c.green },
        GitSignsChange = { fg = c.orange },
        GitSignsDelete = { fg = c.red },

        TabLine = { bg = c.black },
        TabLineSel = { bg = c.black, fg = c.blue, bold = true },
        TabLineFill = { bg = c.black },
        SepOn = { fg = c.blue },
        SepOff = { fg = c.grey },

        TextOn = { fg = c.white },
        TextOff = { fg = c.white },

    },
}

local apply = function(name, args)
    vim.api.nvim_set_hl(0, name, args)
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
