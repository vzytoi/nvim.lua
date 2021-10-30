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
                    require("options").RunCodeBuffer()
                end },
                { 'v', function()
                    vim.api.nvim_command(
                        "vnew|r !" .. M.command()
                    )
                    vim.api.nvim_command("vert res -60")
                    require("options").RunCodeBuffer()
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
