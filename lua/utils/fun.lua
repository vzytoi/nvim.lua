local FN = {}

FN.unwanted = function(bufnr, fts)
    return not nvim.buf_get_option(bufnr, 'modifiable') or
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

    nvim.command(calling)

    vim.g[open] = not vim.g[open]
end

FN.is_last_win = function()
    return #nvim.list_wins() == 1
end

FN.closebuf = function(bufnr)
    local _ = pcall(nvim.command, bufnr .. 'bd')
end

FN.close = function()
    nvim.command('q')
end

FN.getbufpath = function()
    return vim.fn.fnameescape(nvim.buf_get_name(0))
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
        return nvim.buf_is_loaded(nr)
    end, nvim.list_bufs())

end

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

FN.map = function(f, t)
    local t1 = {}
    local t_len = #t
    for i = 1, t_len do
        t1[i] = f(t[i])
    end
    return t1
end

return FN
