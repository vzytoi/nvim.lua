local M = {}

M.copy = function(table)
    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret
end

M.mergeTables = function(a, b)
    local ret = M.copy(a)

    for k, v in pairs(b) do
        ret[k] = v
    end

    return ret
end

M.split = function(string, target)
    local results = {}

    for m in (string .. target):gmatch("(.-)" .. target) do
        table.insert(results, m)
    end

    return results
end

M.toggle = function(open, close)

    if vim.g[open] == nil then
        vim.g[open] = false
    end

    local calling = (vim.g[open] and close or open)

    vim.api.nvim_command(calling)

    vim.g[open] = not vim.g[open]
end

M.is_last_win = function()
    return #vim.api.nvim_list_wins() == 1
end

M.closebuf = function(bufnr)
    local _ = pcall(vim.api.nvim_command, bufnr .. 'bd')
end

M.close = function()
    vim.api.nvim_command('q')
end

M.getbufpath = function()
    return vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
end

M.getfn = function()
    return vim.fn.expand('%:t')
end

M.os = {
    mac = function()
        return vim.fn.has('macunix')
    end,

    win = function()
        return package.config:sub(1, 1) == "\\"
    end
}

M.capabilities = function(capabilitie, bufnr)

    local client = vim.lsp.get_active_clients({ bufnr = bufnr })

    if #client == 0 then
        return false
    end

    local a = {
        format = client[1].server_capabilities.documentFormattingProvider
    }

    return a[capabilitie]

end

return M
