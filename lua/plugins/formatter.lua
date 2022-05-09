local M = {}

M.file_name = function()
    return vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
end

M.uses = { "python" }

M.check_uses = function(ft)

    if ft == nil then
        ft = vim.bo.filetype
    end

    for _, v in ipairs(M.uses) do
        if v == ft then
            return true
        end
    end

    return false
end

M.config = function()
    require("formatter").setup {
        logging = false,
        filetype = {
            javascript = {
                function()
                    return {
                        exe = "prettier",
                        args = {
                            "--stdin-filepath",
                            M.file_name(),
                            "--single-quote",
                            "--tab-width=4",
                            "--no-bracket-spacing",
                            "--arrow-parens=avoid"
                        },
                        stdin = true
                    }
                end
            },
            lua = {
                function()
                    return {
                        exe = "luafmt",
                        args = { "--indent-count", 4, "--stdin" },
                        stdin = true
                    }
                end
            },
            python = {
                function()
                    return {
                        exe = "python3 -m autopep8",
                        args = {
                            "--in-place --aggressive --aggressive"
                        },
                        stdin = false
                    }
                end
            }
        }
    }
end

return M
