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

function M.settings()

 vim.bo.bufhidden = 'delete'
 vim.bo.buftype = 'nofile'
 vim.bo.swapfile = false
 vim.bo.buflisted = false
 vim.wo.winfixheight = true
 vim.wo.number = false
 vim.wo.relativenumber = false

end

function M.time()

    vim.api.nvim_command("!Measure-Command{" .. M.command() .. "}")

end

function M.execute()

    vim.api.nvim_command("!" .. M.command())

end

function M.splitExecute()

    vim.api.nvim_command("split_f|r !" .. M.command())
    vim.api.nvim_command("resize -20")
    M.settings()

end

function M.verticalExecute()

    vim.api.nvim_command("vnew|r ! " .. M.command())
    vim.api.nvim_command("vertical resize -60")
    M.settings()

end

return M
