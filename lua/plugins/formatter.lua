local M = {}

M.fileName = function()
    return vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
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
                            M.fileName(),
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
                        args = {"--indent-count", 4, "--stdin"},
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
