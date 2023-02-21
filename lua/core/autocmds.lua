local M = {}

local general = vim.api.nvim_create_augroup("General Settings", { clear = true })

local line_number = function()
    local dis = u.ft.disabled

    local disln = function()
        if vim.tbl_contains(dis.ln, vim.bo.filetype) then
            vim.wo.rnu = false
            vim.wo.nu = false
        end
    end

    vim.api.nvim_create_autocmd(
        { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        callback = function()
            if vim.fn.mode() ~= "i" then
                vim.wo.rnu = true
                vim.wo.nu = true
            end


            disln()
        end,
        group = general
    })

    vim.api.nvim_create_autocmd(
        { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = true

            disln()
        end,
        group = general
    })


    vim.api.nvim_create_autocmd("FileType", {
        callback = function()
            disln()
        end
    })
end

M.config = function()
    require "plugins.treesitter".autocmds()

    vim.api.nvim_create_augroup('vimrc', {})

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            if vim.tbl_contains(u.ft.close_when_last, vim.bo.filetype)
                and u.fun.is_last_win() then
                u.fun.close()
            end
        end,
        group = general
    })

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            vim.opt.formatoptions:remove { "c", "r", "o" }
        end,
        group = general
    })

    vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
            vim.cmd "checktime"
        end,
        group = general,
    })

    vim.api.nvim_create_autocmd("VimResized", {
        callback = function()
            vim.cmd "wincmd ="
        end,
        group = general,
    })

    line_number()

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "gitcommit", "markdown", "text", "log" },
        callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
        end,
        group = general,
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "ocaml" },
        callback = function()
            vim.bo.shiftwidth = 2
            vim.bo.tabstop = 2
        end
    })
end

return M
