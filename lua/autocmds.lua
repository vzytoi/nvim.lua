local M = {}

local autocmd = vim.api.nvim_create_autocmd
local fn = require('fn')

local last_close = {
    'NvimTree'
}

local no_nu = {
    'toggleterm',
    'fugitive',
}

M.config = function()

    require('plugins.lsp').autocmds()
    require('plugins.runcode').autocmds()

    -- TODO: doesn't work.

    autocmd("BufEnter", {
        pattern = "NvimTree",
        callback = function()
            if fn.is_last_win() then
                fn.close_current_win()
            end
        end
    })

    autocmd('FileType', {
        pattern = no_nu,
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = false
        end
    })

    autocmd("InsertLeave", {
        callback = function()
            if not vim.tbl_contains(no_nu, vim.bo.filetype) then
                vim.opt.rnu = true
            end
        end
    })

    autocmd("InsertEnter", {
        callback = function()
            if not vim.tbl_contains(no_nu, vim.bo.filetype) then
                vim.opt.rnu = false
            end
        end
    })

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

    autocmd("BufWritePre", {
        callback = function()
            vim.lsp.buf.format()
        end
    })

    autocmd("FileType", {
        pattern = { "gitcommit", "markdown", "text" },
        callback = function()
            vim.opt_local.spell = true
        end
    })

end

return M
