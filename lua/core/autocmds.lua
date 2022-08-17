local M = {}

vim.g.autocmd = vim.api.nvim_create_autocmd

vim.g.group = function(name, opts)
    return vim.api.nvim_create_augroup(name, opts or { clear = true })
end

M.config = function()

    vim.g.group('vimrc', {})

    require "plugins.runcode".autocmds()
    require "plugins.treesitter".autocmds()
    require "core.winbar".autocmds()
    require "core.tabline".autocmds()
    require "core.rooter".autocmds()

    local close = {
        fts = {
            'toggleterm', 'NvimTree',
            'RunCode'
        }
    }

    vim.g.autocmd("BufEnter", {
        callback = function()
            if vim.tbl_contains(close.fts, vim.bo.filetype)
                and vim.func.is_last_win() then
                vim.func.close()
            end
        end,
        group = vim.g.group('close-last')
    })

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

    vim.g.autocmd('FileType', {
        pattern = vim.ft.disabled.ln,
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = false
        end,
        group = vim.g.group('no-nu')
    })

    for event, op in pairs(events) do
        vim.g.autocmd(event, {
            callback = function()
                local ft = vim.bo.filetype
                if not vim.tbl_contains(events, ft) then
                    vim.wo.rnu = op
                end
            end
        })
    end

end

return M
