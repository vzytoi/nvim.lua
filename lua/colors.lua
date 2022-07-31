local M = {}

local raw = {
    all = {
        LineNr = { fg = "#6B6B6B" },
        VertSplit = { fg = "#6B6B6B" },
        LspReferenceText = { bold = true },
        LspReferenceRead = { bold = true },
        LspReferenceWrite = { bold = true },
        Normal = { fg = "#EEEEEE" },
        NormalFloat = { bg = "#000000", fg = "#ffffff" },
    },
    gruvbox = {
        Visual = { bg = "Grey40" },
        CursorLineNR = { fg = "#458588", bold = true },
        SignColumn = { bg = "#000000" },
        DiagnosticSignError = { fg = "#cc241d", bold = true },
        DiagnosticSignWarn = { fg = "#fabd2f", bold = true },
        DiagnosticSignHint = { fg = "#b8bb26", bold = true },
        DiagnosticSignInfo = { fg = "#FFC0CB", bold = true },
        StatusLine = { bg = "#000000" }
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
        { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
        { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
        { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "DiagnosticSignHint" })

end

return M
