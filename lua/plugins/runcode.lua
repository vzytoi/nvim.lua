local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'x', ':Execute<CR>' },
            { 'x', {
                { 's', ':SplitExecute<CR>'},
                { 'v', ':VerticalExecute<CR>'},
                { 'e', ':TimeExecute<CR>'},
            }},
        }}
    }

    return map

end

function M.command()

    local ft = {
        ['typescript'] = 'ts-node fp',
        ['lua'] = 'lua fp',
        ['javascript'] = 'node fp',
        ['php'] = 'php fp',
        ['python'] = 'python fp',
        ['c'] = 'gcc fp -o fn.exe;./fn.exe'
    }

    local c = ft[vim.bo.filetype]

    local fn = {
        ['fp'] = vim.fn.expand('%:t'),
        ['fn'] = vim.fn.expand('%:r')
    }

    for k, v in pairs(fn) do
        c = c:gsub(k, v)
    end

    return c
end

function M.settings()

 vim.bo.bufhidden = 'delete'
 vim.bo.buftype = 'nofile'
 vim.bo.swapfile = false
 vim.bo.buflisted = false
 vim.wo.winfixheight = true
 vim.wo.number = false
 vim.wo.relativenumber = false

end

function M.TimeExecute()

    vim.api.nvim_command("!Measure-Command{" .. M.command() .. "}")

end

function M.Execute()

    vim.api.nvim_command("!" .. M.command())

end

function M.SplitExecute()

    vim.api.nvim_command("split_f|r !" .. M.command())
    vim.api.nvim_command("resize -20")
    M.settings()

end

function M.VerticalExecute()

    vim.api.nvim_command("vnew|r ! " .. M.command())
    vim.api.nvim_command("vertical resize -60")
    M.settings()

end

function M.commands()

    local c = {
        "Execute",
        "SplitExecute",
        "VerticalExecute",
        "TimeExecute"
    }

    for i, _ in ipairs(c) do
        vim.api.nvim_command(
            'command! ' .. c[i] .. ' lua require("runcode").' .. c[i] .. '()')
    end

end

return M
