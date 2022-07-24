local M = {}

M.raw = {
    all = {
        LineNr = { guifg = "#6B6B6B" },
        VertSplit = { guifg = "#6B6B6B" },
        LspReferenceText = { cterm = "bold", gui = "bold" },
        LspReferenceRead = { cterm = "bold", gui = "bold" },
        LspReferenceWrite = { cterm = "bold", gui = "bold" },
        Normal = { guifg = "#EEEEEE", guibg = "#000000" },
    },
    gruvbox = {
        Visual = { ctermbg = 0, guibg = "Grey40" },
        CursorLineNR = { guifg = "#458588", gui = "bold" }
    },
}

M.apply = function(name, args)
    local opt = {
        "guifg",
        "guibg",
        "gui",
        "guisp",
        "cterm"
    }

    vim.cmd(string.format("hi clear %s", name))

    local s = string.format("hi %s", name)

    for _, value in ipairs(opt) do
        local v = args[value] or "NONE"

        s = table.concat({ s, table.concat({ value, v }, "=") }, " ")
    end

    vim.cmd(s)
end

M.undeep = function(v)
    for k, _ in pairs(v[2]) do
        v[2][k] = vim.tbl_extend('keep', v[2][k], v[1])
    end

    return v[2]
end

M.sort = function(hi)
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

    local o = M.sort(M.raw)

    for k, _ in ipairs(o) do
        print(k)
    end

    for k, _ in pairs(o) do
        if k == "_" then
            o = vim.tbl_extend('keep', M.undeep(o[k]), o)
        end
    end

    for k, v in pairs(o) do
        if k ~= "_" then
            M.apply(k, v)
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
