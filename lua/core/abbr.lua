local M = {}

function M.config()
    local abbreviations = {
        wrap = "set wrap",
        nowrap = "set nowrap",
        nws = "set nowrapscan! nowrapscan?",
        ps = "PackerSync",
        msg = "messages",
        WA = "wa",
        svp = "vsp"
    }

    for l, r in pairs(abbreviations) do
        vim.cmd(string.format("cnorea %s %s", l, r))
    end
end

return M
