local M = {}

local fn = require("fn")

M.raw = {
    all = {
        LineNr = {guifg = "#6B6B6B"},
        VertSplit = {guifg = "#6B6B6B"},
        LspReferenceText = {cterm = "bold", gui = "bold"},
        LspReferenceRead = {cterm = "bold", gui = "bold"},
        LspReferenceWrite = {cterm = "bold", gui = "bold"}
    },
    gruvbox = {
        Normal = {guifg = "#EEEEEE", guibg = "#000000"},
        Visual = {ctermbg = 0, guibg = "Grey40"},
        CursorLineNR = {guifg = "#458588", gui = "bold"}
    }
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

        s = table.concat({s, table.concat({value, v}, "=")}, " ")
    end

    vim.cmd(s)
end

M.undeep = function(v)
    for k, _ in pairs(v[2]) do
        v[2][k] = fn.mergeTables(v[2][k], v[1])
    end

    return v[2]
end

M.sort = function(hi)
    local o = {}

    for k, _ in pairs(hi) do
        if k == vim.g.colors_name or k == "all" then
            o = fn.mergeTables(o, hi[k])
        end
    end

    return o
end

M.config = function()
    require("opts").ColorOpt()

    local o = M.sort(M.raw)

    for k, _ in ipairs(o) do
        print(k)
    end

    for k, _ in pairs(o) do
        if k == "_" then
            o = fn.mergeTables(M.undeep(o[k]), o)
        end
    end

    for k, v in pairs(o) do
        if k ~= "_" then
            M.apply(k, v)
        end
    end
    vim.cmd(
        [[
        sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
        sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
        sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
        sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint
        ]]
    )
end

return M
