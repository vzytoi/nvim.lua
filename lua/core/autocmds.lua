local M = {}

vim.g.autocmd = nvim.create_autocmd

vim.g.group = function(name, opts)
    return nvim.create_augroup(name, opts or { clear = true })
end

M.config = function()

    vim.g.group('vimrc', {})

    require "plugins.runcode".autocmds()
    require "plugins.treesitter".autocmds()
    require "plugins.time".autocmds()
    require "core.tabline".autocmds()
    require "core.winbar".autocmds()
    require "core.linter".autocmds()

    local close = {
        fts = {
            'toggleterm', 'NvimTree',
            'RunCode'
        }
    }

    vim.g.autocmd("BufEnter", {
        callback = function()
            if vim.tbl_contains(close.fts, vim.bo.filetype)
                and u.fun.is_last_win() then
                u.fun.close()
            end
        end,
        group = vim.g.group('close-last')
    })

    local dis = u.ft.disabled

    local events = {
        InsertLeave = true,
        WinEnter = true,
        BufEnter = true,
        FocusGained = true,
        InsertEnter = false,
        WinLeave = false,
        FocusLost = false,
        BufNewFile = false,
        BufReadPost = false,
    }

    for event, op in pairs(events) do
        vim.g.autocmd(event, {
            callback = function()
                local ft = vim.bo.filetype

                if not vim.tbl_contains(dis.ln, ft) then
                    vim.wo.rnu = op
                else
                    vim.wo.rnu = false
                    vim.wo.nu = false
                end
            end
        })
    end

    vim.g.autocmd("FileType", {
        callback = function()
            local ft = vim.bo.filetype
            local unwanted = u.fun.unwanted(0)

            if vim.tbl_contains(dis.spell, ft) or unwanted then
                vim.schedule(function()
                    vim.wo.spell = false
                end)
            end
        end,
        group = vim.g.group('no-nu')
    })

end

return M
