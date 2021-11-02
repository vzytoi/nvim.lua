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

    if dir ~= 'x' then
        require('options').RunCodeBuffer()
        M.resize(dir)
    end

end

function M.time()

    local t = vim.fn.system(
        string.format(
            "(Measure-Command{%s}).ToString()",
            M.command()
        )
    )

    local ft = {0, 0, 0, 0}
    local c = 1

    for str in string.gmatch(t, "([^:|.]+)") do
        ft[c] = tonumber(str)
        c = c + 1
    end

    ft[4] = math.floor(ft[4] / 10000)

    local t = {"h", "m", "s", "ms"}

    local r = ""

    for i = 1, 4 do
        if ft[i] ~= 0 then
            r = string.format(
                "%s %s%s",
                r, ft[i], t[i]
            )
        end
    end

    print(
        string.format(
            "%s:%s",
            vim.fn.expand('%:t'),
            r
        )
    )

end

function M.resize(dir)

    local lines = vim.fn.getline(1, '$')
    local m = 0

    if dir == 's' then
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

    local sd = ""
    if dir == 'v' then
        sd = "vert"
    end

    vim.api.nvim_command(
        string.format("%s res %s", sd, m + 10)
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
