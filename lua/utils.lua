local utils = {}

function utils.is_win()
    return package.config:sub(1, 1) == "\\"
end

function utils.copy(table)
    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret
end

function utils.mergeTables(a, b)
    local ret = utils.copy(a)

    for k, v in pairs(b) do
        ret[k] = v
    end

    return ret
end

function utils.split(string, target)
    local results = {}

    for m in (string .. target):gmatch("(.-)" .. target) do
        table.insert(results, m)
    end

    return results
end

function utils.subrange(t, first, last)
    return table.move(t, first, last, 1, {})
end

function utils.selection()
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

utils.opts = {noremap = true, silent = true}
local fn_store = {}

local function register_fn(fn)
    table.insert(fn_store, fn)
    return #fn_store
end

function utils.apply_function(id)
    fn_store[id]()
end

function utils.apply_expr(id)
    return vim.api.nvim_replace_termcodes(fn_store[id](), true, true, true)
end

function utils.lua_fn(fn)
    return string.format("<cmd>lua require('%s').apply_function(%s)<CR>", module_name, register_fn(fn))
end

function utils.lua_expr(fn)
    return string.format("v:lua.require'%s'.apply_expr(%s)", module_name, register_fn(fn))
end

return utils
