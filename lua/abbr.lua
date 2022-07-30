local M = {}

function M.config()
    local abbreviations = {
        wrap = "set wrap",
        nowrap = "set nowrap",
        X = "x",
        Q = "q",
        ["<"] = "w",
        nws = "set nowrapscan! nowrapscan?",
        ps = "PackerSync",
        cs = "colorscheme",
        w = "w | echon ''"
    }

    for l, r in pairs(abbreviations) do
        vim.cmd(string.format("cnoreabbrev %s %s", l, r))
    end
end

return M
