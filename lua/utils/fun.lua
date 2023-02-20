local FN = {}

FN.unwanted = function(bufnr, fts)
    return not vim.api.nvim_buf_get_option(bufnr, 'modifiable') or
        (fts and vim.tbl_contains(fts, FN.buf(bufnr, 'filetype')))
end

FN.toboolean = function(n)
    if type(n) ~= n then
        return
    end
    return n > 0
end

FN.round = function(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

FN.timer_start = function()
    FN.timer = vim.fn.reltime()
end

FN.timer_end = function()
    local time = vim.fn.reltimefloat(
        vim.fn.reltime(FN.timer)
    )

    local sec = time > 1

    return {
        time = sec and FN.round(time, 2) or FN.round(time * 1000),
        unit = sec and "s" or "ms"
    }
end

FN.copy = function(table)
    local ret = {}
    for k, v in pairs(table) do
        ret[k] = v
    end
    return ret
end

FN.file_empty = function(bufnr)
    return vim.fn.getfsize(FN.buf(bufnr, 'filepath')) <= 1
end

FN.table = {
    merge = function(a, b)
        local ret = FN.copy(a)

        for k, v in pairs(b) do
            ret[k] = v
        end

        return ret
    end,

}

FN.toggle = function(open, close)

    if vim.g[open] == nil then
        vim.g[open] = false
    end

    local calling = (vim.g[open] and close or open)

    vim.api.nvim_command(calling)

    vim.g[open] = not vim.g[open]
end

FN.is_last_win = function()
    return #vim.api.nvim_list_wins() == 1
end

FN.capabilities = function(capabilitie, bufnr)

    local client = vim.lsp.get_active_clients({ bufnr = bufnr })

    if vim.tbl_isempty(client) then
        return false
    end

    local a = {
        format = client[1].server_capabilities.documentFormattingProvider,
        hi = client[1].supports_method('textDocument/documentHighlight')
    }

    return a[capabilitie]

end

FN.is_empty = function(obj)
    return obj == nil or obj == ""
end

FN.keycount = {
    ["&"] = 1,
    ["é"] = 2,
    ['"'] = 3,
    ["'"] = 4,
    ["("] = 5,
    ["§"] = 6,
    ["è"] = 7,
    ["!"] = 8,
    ["ç"] = 9
}


FN.buf = function(asked, bufnr)

    bufnr = bufnr or vim.fn.bufnr()

    local infos = {
        filename = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t'),
        filetype = vim.fn.getbufvar(bufnr, "&filetype"),
        filepath = vim.fn.expand('%:p'),
        filetag = vim.fn.expand('%:t:r'),
        bufnr = bufnr
    }

    return infos[asked]

end

vim.g.mp = false

FN.mp2i = function()
    if not vim.g.mp then
        require('cmp').setup.buffer { enabled = false}
        vim.g.nvim_virtual_enable = false
        vim.diagnostic.disable()
    else
        require('cmp').setup.buffer { enabled = true}
        vim.g.nvim_virtual_enable = true
        vim.diagnostic.enable()
    end

    vim.g.mp = not vim.g.mp
end

vim.api.nvim_create_user_command("MP", ":lua u.fun.mp2i()",{})

return FN
