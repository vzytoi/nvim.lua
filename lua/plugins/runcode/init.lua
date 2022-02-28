local M = {}

function M.setup()

    local keymap = function(dir)
        return string.format(
            ":lua require('plugins.runcode').run('visual', '%s')<cr>",
            dir
        )
    end

    for _, v in pairs({'x', 'xs', 'xv'}) do
        vim.api.nvim_set_keymap(
            'v', '<leader>' .. v, keymap(v:sub(1,1)),
        {noremap = true})
    end

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

M.logPath = vim.fn.stdpath('data') .. '\\runcode_log\\*'

function M.getLog()

    vim.api.nvim_command(string.format(
        '!Get-Item %s', M.logPath
    ))

end

function M.clearLog()

    vim.api.nvim_command(string.format(
        '!Remove-Item %s -Recurse -Force', M.logPath
    ))

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

local function startswith(str, start)
    return string.sub(str, 1, string.len(start)) == start
end

function M.run(mode, dir)

    local lang = require('plugins.runcode.lang')

    if vim.bo.filetype == 'runcode' then
        print('RROR: unexecutable filetype')
        return false
    end

    if mode == 'visual' then

        -- TODO: c & cpp languages still don't work using visual
        -- .\foo.exe don't work using full path (12/12/2021 01:42:53)

        local select = selection()
        local intro = lang.intro[vim.bo.filetype]

        if intro ~= nil and startswith(select, intro) ~= true then
            select = string.format(
                '%s\n%s', intro, select
            )
        end

        write(lang.sub.visual['#'], select)

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
