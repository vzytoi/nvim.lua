local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'x', function()
                M.run('x')
            end },
            { 'x', {
                { 's', function()
                    M.run('s')
                end },
                { 'v', function()
                    M.run('v')
                end },
                { 'e', function()
                    M.time()
                end }
            }},
        }}
    }

    return map

end

function M.run(dir)

    local d = {
        s = "split_f|r !",
        v = "vnew|r !",
        x = "!"
    }

    vim.api.nvim_command(
        d[dir] .. M.command()
    )

end

function M.time()

    local d = {
        "Milliseconds", "Seconds", "Minutes"
    }

    local s
    local f

    for _, v in pairs(d) do
        s =
        vim.fn.system(
            string.format(
                "((Measure-Command{%s}).Total%s).ToString()",
                M.command(), v
            )
        )
        if tonumber(string.sub(s, 1, 1)) > 0 then
            f = v
            break
        end
    end

    print(
        string.format(
            "%s %s",
            string.gsub(s, "[\r\n]", ""), f
        )
    )

end

function M.resize(dir)
    dir = dir or ""

    local lines = vim.fn.getline(1, '$')
    local m = 0

    if string.len(dir) == 0 then
        m = #lines
    else
        for _, v in pairs(lines) do
            if string.len(v) > m then
                m = string.len(v)
            end
        end
        if m > 150 then
            m = 75
        end
    end

    vim.api.nvim_command(
        string.format("%s res %s", dir, m + 10)
    )

end

function M.command()

    local ft = require('plugins.runcode.lang')
    local c = ft['lang'][vim.bo.filetype]

    if not c then
        c = string.format(
            "%s #", vim.bo.filetype
        )
    end

    for k, v in pairs(ft['sub']) do
        c = c:gsub(k, vim.fn.expand(v))
    end

    return c

end

return M
