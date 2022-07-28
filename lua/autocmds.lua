local M = {}

local autocmd = vim.api.nvim_create_autocmd

M.config = function()

    require('plugins.runcode').autocmds()

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
            'RunCode'
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

    autocmd("BufReadPost", {
        callback = function()
            local size = vim.fn.getfsize(vim.fn.expand("%"))

            if size >= 1000000 then
                for hl_name, _ in pairs(vim.api.nvim__get_hl_defs(0)) do
                    vim.api.nvim_set_hl(0, hl_name, {})
                end
            elseif size >= 500000 then
                vim.api.nvim_command("silent! TSBufDisable highlight")
            elseif vim.g.TS_disabled then
                vim.api.nvim_command("!write | edit | TSBufEnable highlight")
            end

            vim.g.TS_disabled = size >= 50000

        end
    })

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

end

return M
