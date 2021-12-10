local M = {}

function M.setup()

    local keymap = function(dir)
        return string.format(
            ":lua require('plugins.runcode').run('visual', '%s')<cr>",
            dir
        )
    end

    for _, v in ipairs({'x', 'xs', 'xv'}) do
        vim.api.nvim_set_keymap(
            'v', '<leader>' .. v, keymap(v:sub(1,1)),
        {noremap = true})
    end

    vim.api.nvim_set_keymap(
        'v', '<leader>xe',
        ":lua require('plugins.runcode').time('visual')<cr>",
        {noremap = true}
    )

    local map = {
        { '<leader>', {
            { 'x', function()
                M.run('normal', 'x')
            end },
            { 'x', {
                { 's', function()
                    M.run('normal', 's')
                end },
                { 'v', function()
                    M.run('normal', 'v')
                end },
                { 'e', function()
                    M.time('normal')
                end }
            }},
        }}
    }

    return map

end

local function selection()

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

    return table.concat(lines, '\n')

end

local function write(filename, data)

    local file = io.open(filename, "w")

    file:write(data)
    file:close()

end

function M.command(mode)

    local ft = require('plugins.runcode.lang')
    local c = ft['lang'][vim.bo.filetype]

    if not c then
        c = string.format(
            "%s #", vim.bo.filetype
        )
    end

    for k, v in pairs(ft['sub'][mode]) do
        c = c:gsub(k, vim.fn.expand(v))
    end

    return c

end

function M.run(mode, dir)

    if mode == 'visual' then
        write(
            require('plugins.runcode.lang').sub.visual['#'],
            selection()
        )
    end

    local d = {
        s = 'split_f|r !',
        v = 'vnew|r !',
        x = '!'
    }

    vim.api.nvim_command(d[dir] .. M.command(mode))

    if dir ~= 'x' then
        require('options').RunCodeBuffer()
        M.resize(dir)
    end

end

function M.time(mode)

    local t = vim.fn.system(
        string.format(
            "Measure-Command { Invoke-Expression '%s'} | Select -ExpandProperty TotalMilliseconds",
            M.command(mode)
        )
    ):gsub('\n', ''):gsub(',', '.')

    t = tonumber(t)

    local times = {'ms', 's', 'm', 'h'}

    local dimentions = {
        1,
        1000,
        60,
        60
    }

    local c = 1

    while t >= 1000 do
        t = t / dimentions[c]
        c = c + 1
    end

    print(t, times[c])

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

return M
