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

    local numbers = {
        fts = {
            'toggleterm', 'fugitive',
            'RunCode', 'help',
            'NvimTree', 'harpoon', 'sagarename'
        },
        relative = {
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
    }

    vim.g.autocmd('FileType', {
        pattern = numbers.fts,
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = false
        end,
        group = vim.g.group('no-nu')
    })

    for event, op in pairs(numbers.relative) do
        vim.g.autocmd(event, {
            callback = function()
                if not vim.tbl_contains(numbers.fts, vim.bo.filetype) then
                    vim.wo.rnu = op
                end
            end
        })
    end

    --[[ vim.g.autocmd({ "BufEnter", "CursorMoved" }, {
        callback = function()
            vim.opt_local.winbar = require('core.winbar').get()
        end,
        group = vim.g.group('winbar')
    }) ]]

    vim.g.autocmd("BufEnter", {
        callback = function()
            vim.api.nvim_set_option_value("tabline", require('core.tabline').get(), { scope = "local" })
        end
    })

end

return M
