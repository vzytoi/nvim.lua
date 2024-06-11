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

    -- vim.api.nvim_create_autocmd("BufEnter", {
    --     callback = function()
    --         require('cmp').setup.buffer { enabled = false }
    --     end
    -- })

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

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            if vim.fn.argc() == 0 then
                local builtin = require("telescope.builtin")
                builtin.find_files()
            end
        end,
        group = general
    })

    line_number()

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "ocaml" },
        callback = function()
            vim.bo.shiftwidth = 2
            vim.bo.tabstop = 2
        end
    })

    -- just to don't get lost
    -- vim.api.nvim_create_autocmd("FocusLost", {
    --     callback = function()
    --         if vim.bo.filetype ~= "tex" then
    --             vim.api.nvim_command("stopi")
    --         end
    --     end
    -- })

    -- vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "tex",
    --     callback = function()
    --         vim.wo.wrap = true
    --         vim.wo.lbr = true
    --     end
    -- })

    vim.api.nvim_create_autocmd("Filetype", {
        callback = function()
            vim.schedule(function()
                if vim.tbl_contains(u.ft.nospell, vim.bo.filetype) then
                    vim.opt_local.spell = false
                end
            end)
        end
    })

    vim.api.nvim_create_augroup("neogit-additions", {})

    vim.api.nvim_create_autocmd("FileType", {
        group = "neogit-additions",
        pattern = "NeogitCommitMessage",
        command = "silent! set filetype=gitcommit",
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
            vim.cmd("set tw=95")
        end
    })
end

return M
