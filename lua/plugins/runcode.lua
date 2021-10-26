local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'x', function()
                vim.api.nvim_command("!" .. M.command())
            end },
            { 'x', {
                { 's', function()
                    vim.api.nvim_command(
                        "split_f|r !" .. M.command()
                    )
                    vim.api.nvim_command("res -20")
                    require("../options").execute()
                end },
                { 'v', function()
                    vim.api.nvim_command(
                        "vnew|r !" .. M.command()
                    )
                    vim.api.nvim_command("vert res -60")
                    require("../options").execute()
                end },
                { 'e', function()
                    vim.api.nvim_command(
                        "!Measure-Command{" .. M.command() .. "}"
                    )
                end }
            }},
        }}
    }

    return map

end

function M.command()

    local ft = {
        ['typescript'] = 'ts-node fp',
        ['javascript'] = 'node fp',
        ['c'] = 'gcc fp -o fn.exe;./fn.exe'
    }

    local c = ft[vim.bo.filetype]

    if not c then
        c = vim.bo.filetype .. ' fp'
    end

    local fn = {
        ['fp'] = vim.fn.expand('%:t'),
        ['fn'] = vim.fn.expand('%:r')
    }

    for k, v in pairs(fn) do
        c = c:gsub(k, v)
    end

    return c
end

return M
