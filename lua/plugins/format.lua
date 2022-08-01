local M = {}

local null = require('null-ls')

local formatters = {
    python = null.builtins.formatting.black:with({
        extra_args = { "--fast" }
    })
}

M.config = function()
    null.setup {
        sources = vim.tbl_values(formatters)
    }
end

M.get = function()
    return vim.tbl_keys(formatters)
end

return M
