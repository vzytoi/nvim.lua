local M = {}

local autocmd = vim.api.nvim_create_autocmd

M.config = function()

    require('plugins.runcode').autocmds()
    require('plugins.treesitter').autocmds()

    local close = {
        fts = {
            'toggleterm',
            'NvimTree',
            'RunCode'
        }
    }

    autocmd("BufEnter", {
        callback = function()
            if vim.g.fn.has(close.fts, vim.bo.filetype)
                and vim.g.fn.is_last_win() then
                vim.g.fn.close()
            end
        end
    })

    local numbers = {
        fts = {
            'toggleterm',
            'fugitive',
            'RunCode',
            'help',
            'NvimTree'
        },
        relative = {
            InsertEnter = false,
            WinLeave = false,
            FocusLost = false,
            BufNewFile = false,
            BufReadPost = false,
            InsertLeave = true,
            WinEnter = true,
            FocusGained = true
        }
    }

    autocmd('FileType', {
        pattern = numbers.fts,
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = false
        end
    })

    for event, op in pairs(numbers.relative) do
        autocmd(event, {
            callback = function()
                if not vim.g.fn.has(numbers.fts, vim.bo.filetype) then
                    vim.wo.rnu = op
                end
            end
        })
    end

    autocmd("FileType", {
        pattern = "gitcommit",
        callback = function()
            require("cmp").setup.buffer({ enable = false })
        end
    })

    autocmd("VimResized", {
        command = "wincmd ="
    })

    autocmd("FileType", {
        pattern = { "gitcommit", "markdown", "text" },
        callback = function()
            vim.opt_local.spell = true
        end
    })

    autocmd("FileType", {
        callback = function()
            vim.cmd("set fo-=o")
            vim.cmd("set fo-=a")
            vim.cmd("set fo-=2")

            vim.cmd("set fo+=t")
            vim.cmd("set fo+=c")
            vim.cmd("set fo+=r")
            vim.cmd("set fo+=q")
            vim.cmd("set fo+=n")
            vim.cmd("set fo+=j")

            vim.cmd("set shortmess+=W")
        end
    })

    autocmd("CursorHold", {
        command = "echon ''"
    })

end

return M
