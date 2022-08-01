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
        green  = "#b8bb26",
        yellow = "#fabd2f"
    }
}

local raw = {
    all = {
        LineNr = { fg = "#6B6B6B" },
        VertSplit = { fg = "#6B6B6B" },
        LspReferenceText = { bold = true },
        LspReferenceRead = { bold = true },
        LspReferenceWrite = { bold = true },
    },
    gruvbox = {
        Normal = { fg = "#EEEEEE", bg = M.colors.gruvbox.black },
        NormalFloat = { bg = M.colors.gruvbox.black, fg = "#ffffff" },
        Visual = { bg = "Grey40" },
        CursorLineNR = { fg = "#458588", bold = true },
        DiagnosticSignError = { fg = M.colors.gruvbox.red, bold = true },
        DiagnosticSignWarn = { fg = M.colors.gruvbox.yellow, bold = true },
        DiagnosticSignHint = { fg = M.colors.gruvbox.green, bold = true },
        DiagnosticSignInfo = { fg = M.colors.gruvbox.grey, bold = true },
        StatusLine = { bg = M.colors.gruvbox.black },
        SignColumn = { bg = M.colors.gruvbox.black, bold = true },
        GitSignsAdd = { fg = M.colors.gruvbox.green },
        GitSignsChange = { fg = M.colors.gruvbox.orange },
        GitSignsDelete = { fg = M.colors.gruvbox.red },
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
