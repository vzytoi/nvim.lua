local M = {}

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

function M.time()

    vim.api.nvim_command("!Measure-Command{" .. M.command() .. "}")

end

function M.execute()

    vim.api.nvim_command("!" .. M.command())

end

return M
