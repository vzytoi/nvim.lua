local M = {}

local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

M.config = function()

    require('plugins.runcode').autocmds()
    require('plugins.treesitter').autocmds()

    local close = {
        fts = {
            'toggleterm', 'NvimTree',
            'RunCode'
        }
    }

    autocmd("BufEnter", {
        callback = function()
            if vim.tbl_contains(close.fts, vim.bo.filetype)
                and vim.func.is_last_win() then
                vim.func.close()
            end
        end,
        group = augroup('close-last')
    })

    local numbers = {
        fts = {
            'toggleterm', 'fugitive',
            'RunCode', 'help',
            'NvimTree', 'harpoon'
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

    autocmd('FileType', {
        pattern = numbers.fts,
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = false
        end,
        group = augroup('no-nu')
    })

    for event, op in pairs(numbers.relative) do
        autocmd(event, {
            callback = function()
                if not vim.tbl_contains(numbers.fts, vim.bo.filetype) then
                    vim.wo.rnu = op
                end
            end
        })
    end

    autocmd("VimResized", {
        command = "wincmd =",
        group = augroup('auto-resize')
    })

    autocmd("FileType", {
        pattern = { "gitcommit", "markdown", "text" },
        callback = function()
            vim.opt_local.spell = true
        end,
        group = augroup('set-spell')
    })

    --[[ autocmd({ "BufEnter", "CursorMoved" }, {
        callback = function()
            vim.opt_local.winbar = require('winbar').get()
        end,
        group = augroup('winbar')
    })
]]
end

return M
