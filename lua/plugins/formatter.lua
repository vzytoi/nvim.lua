local M = {}

M.uses = function()
    local map = {
        python = true,
        javascript = false,
        lua = false,
        go = false,
        rust = false,
        php = false
    }

    return map[vim.bo.filetype]
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
                            vim.g.fn.getbufpath(),
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
