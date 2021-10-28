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
        ['typescript'] = 'ts-node #',
        ['javascript'] = 'node #',
        ['c'] = 'gcc # -o @.exe;./@.exe'
    }

    local c = ft[vim.bo.filetype]

    if not c then
        c = vim.bo.filetype .. ' #'
    end

    local cl = {
        ['#'] = '%:t',
        ['@'] = '%:r'
    }

    for k, v in pairs(cl) do
        c = c:gsub(k, vim.fn.expand(v))
    end

    return c
end

return M
