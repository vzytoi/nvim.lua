local M = {}

function M.setup()

    local keymap = function(dir)
        return string.format(
            ":lua require('plugins.runcode').run('visual', '%s')<cr>",
            dir
        )
    end

    local opts = {noremap = true}

    vim.api.nvim_set_keymap('v', '<leader>x', keymap('x'), opts)
    vim.api.nvim_set_keymap('v', '<leader>xs', keymap('s'), opts)
    vim.api.nvim_set_keymap('v', '<leader>xv', keymap('v'), opts)

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
                    M.time()
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
        write(require('plugins.runcode.lang').sub.visual['#'], selection())
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

function M.time()

    local t = vim.fn.system(
        string.format(
            "(Measure-Command{%s}).ToString()",
            M.command('normal')
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

return M
