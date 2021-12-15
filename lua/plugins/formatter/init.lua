local M = {}

M.form = require('plugins.formatter.formats')

function M.setup()

    return {
        { '<leader>', {
            { 'o', function()
                M.run('n')
            end }
        }},
        { mode = 'v', {
            { '<leader>', {
                { 'o', function()
                    M.run('v')
                end }
            }}
        }}
    }

end

local visual_bytes = function(side)

    local line = vim.fn.line
    local l2b = vim.fn.line2byte

    local res = {
        ['--range-start '] = l2b(line("'<")),
        ['--range-end '] = l2b(line("'>")),
    }

    return side .. res[side]

end

function M.command(mode)

    print(mode)

    local curr = M.form.formats[vim.bo.filetype]
    local cmd = curr.cmd

    for k, v in pairs(M.form.sub) do
        cmd = cmd:gsub(k, vim.fn.expand(v))
    end

    local function set_opt(cmd, v)
        return string.format(
            '%s %s', cmd, v
        )
    end

    for _, v in pairs(curr.opts) do
        if type(v) ~= 'table' then
            cmd = set_opt(cmd, v)
        elseif mode == 'v' then
            for _, vv in pairs(curr.opts['visual']) do
                cmd = set_opt(cmd, visual_bytes(vv))
            end
        end
    end

    return cmd

end

function M.run(mode)

    vim.cmd('silent w!')
    vim.cmd('silent !' .. M.command(mode))
    vim.cmd('silent e')

end

return M
