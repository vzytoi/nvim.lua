local FN = {}

FN.copy = function(table)
    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret
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

FN.split = function(string, target)
    local results = {}

    for m in (string .. target):gmatch("(.-)" .. target) do
        table.insert(results, m)
    end

    return results
end

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

FN.closebuf = function(bufnr)
    local _ = pcall(vim.api.nvim_command, bufnr .. 'bd')
end

FN.close = function()
    vim.api.nvim_command('q')
end

FN.getbufpath = function()
    return vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
end

FN.get_filename = function()
    return vim.fn.expand('%:t')
end

FN.os = {
    mac = function()
        return vim.fn.has('macunix')
    end,

    win = function()
        return package.config:sub(1, 1) == "\\"
    end
}

FN.capabilities = function(capabilitie, bufnr)

    local client = vim.lsp.get_active_clients({ bufnr = bufnr })

    if #client == 0 then
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

FN.scandir = function(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')

    if pfile ~= nil then
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
    else
        return false
    end

    return vim.list_slice(t, 3, #t)
end

FN.str_repeat = function(str, count)

    local res = ""

    for _ = 1, count do
        res = res .. str
    end

    return res
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

FN.buflst = function()

    return vim.tbl_filter(function(nr)
        return vim.api.nvim_buf_is_loaded(nr)
    end, vim.api.nvim_list_bufs())

end

FN.buf = function(bufnr, asked)

    local infos = {
        filename = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t'),
        filetype = vim.fn.getbufvar(bufnr, "&filetype"),
        filepath = vim.fn.bufname(bufnr),
        bufnr = bufnr
    }

    if asked then
        return infos[asked]
    end

    return infos

end

return FN
