local M = {}

function M.config()

    require('formatter').setup({
        filetype = {
            lua = {
                function()
                    return {
                        exe = "luafmt",
                        args = {"--indent-count", 4, "--stdin"},
                        stdin = true
                    }
                end
            },
        }
    })

end

return M
