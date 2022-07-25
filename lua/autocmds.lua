local M = {}

local autocmd = vim.api.nvim_create_autocmd
local fn = require('fn')

M.last_close = {
    'NvimTree'
}

M.no_nu = {
    'toggleterm',
    'fugitive',
    'spectre_panel'
}

M.config = function()

    require('plugins.lsp').autocmds()
    require('plugins.runcode').autocmds()

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = M.last_close,
        callback = function()
            if fn.is_last_win() then
                fn.close_current_win()
            end
        end
    })

    autocmd('FileType', {
        pattern = M.no_nu,
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = false
        end
    })

    autocmd("InsertLeave", {
        callback = function()
            if not vim.tbl_contains(M.no_nu, vim.bo.filetype) then
                vim.opt.rnu = true
            end
        end
    })

    autocmd("InsertEnter", {
        callback = function()
            if not vim.tbl_contains(M.no_nu, vim.bo.filetype) then
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

    autocmd("BufWritePost", {
        callback = function()
            local use = require('plugins.formatter').uses()
            if use then
                vim.api.nvim_command('FormatWrite')
            elseif use ~= nil then
                vim.lsp.buf.format()
            end
        end
    })

    autocmd("FileType", {
        pattern = { "gitcommit", "markdown", "text" },
        callback = function()
            vim.opt_local.spell = true
        end
    })

    autocmd("FileType", {
        callback = function()
            vim.cmd('setlocal formatoptions-=cro')
        end
    })

end

return M
