local M = {}

function M.is_win()
    return package.config:sub(1, 1) == "\\"
end

function M.copy(table)
    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret
end

function M.mergeTables(a, b)
    local ret = M.copy(a)

    for k, v in pairs(b) do
        ret[k] = v
    end

    return ret
end

function M.split(string, target)
    local results = {}

    for m in (string .. target):gmatch("(.-)" .. target) do
        table.insert(results, m)
    end

    return results
end

function M.subrange(t, first, last)
    return table.move(t, first, last, 1, {})
end

function M.selection()
    local s = vim.fn.getpos("'<")
    local e = vim.fn.getpos("'>")
    local nl = math.abs(e[2] - s[2]) + 1

    local lines = vim.api.nvim_buf_get_lines(0, s[2] - 1, e[2], false)
    lines[1] = string.sub(lines[1], s[3], -1)

    if nl == 1 then
        lines[nl] = string.sub(lines[nl], 1, e[3] - s[3] + 1)
    else
        lines[nl] = string.sub(lines[nl], 1, e[3])
    end

    return table.concat(lines, "\n")
end

M.opts = { noremap = true, silent = true }

function M.toggle(open, close)

    if vim.g[open] == nil then
        vim.g[open] = false
    end

    local calling = (vim.g[open] and close or open)

    vim.api.nvim_command(calling)

    vim.g[open] = not vim.g[open]
end

function M.scandir(directory)

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

return M
