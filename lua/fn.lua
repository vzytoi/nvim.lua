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

M.has_value = function(tab, val)

    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false

end

function M.subrange(t, first, last)
    return table.move(t, first, last, 1, {})
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

M.is_last_win = function()
    return #vim.api.nvim_list_wins() == 1
end

M.close_current_win = function()
    vim.api.nvim_command('q')
end

M.close = function(bufnr)
    local ok, _ = pcall(vim.api.nvim_command, bufnr .. 'bd')
end

M.starstwith = function(string, search)
    return string:find('^' .. search) ~= nil
end

function M.lazy_require(module)

    local mt = {}

    mt.__index = function(_, key)
        if not mt._module then
            mt._module = require(module)
        end

        return mt._module[key]
    end

    mt.__newindex = function(_, key, val)
        if not mt._module then
            mt._module = require(module)
        end

        mt._module[key] = val
    end

    mt.__metatable = false

    return setmetatable({}, mt)

end

function M.is_mac()

    return vim.fn.has('macunix')

end

return M
