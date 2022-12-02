local M = {}

vim.g.autocmd = nvim.create_autocmd

vim.g.group = function(name, opts)
    return nvim.create_augroup(name, opts or { clear = true })
end

M.config = function()

    vim.g.group('vimrc', {})

    require "plugins.treesitter".autocmds()
    require "plugins.time".autocmds()
    require "core.tabline".autocmds()
    require "core.winbar".autocmds()
    require "core.linter".autocmds()
    require "core.rooter".autocmds()

    vim.g.autocmd("BufEnter", {
        callback = function()
            if vim.tbl_contains(u.ft.close_when_last, vim.bo.filetype)
                and u.fun.is_last_win() then
                u.fun.close()
            end
        end,
        group = vim.g.group('close-last')
    })

    local dis = u.ft.disabled

    local disln = function()
        if vim.tbl_contains(dis.ln, vim.bo.filetype) then
            vim.wo.rnu = false
            vim.wo.nu = false
        end
    end

    vim.g.autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        callback = function()
            if vim.fn.mode() ~= "i" then
                vim.wo.rnu = true
                vim.wo.nu = true
            end


            disln()
        end
    })

    vim.g.autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        callback = function()
            vim.wo.rnu = false
            vim.wo.nu = true

            disln()
        end
    })

    vim.g.autocmd("FileType", {
        callback = function()
            disln()
        end
    })

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
