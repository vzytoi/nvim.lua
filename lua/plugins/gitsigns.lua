local M = {}

M.config = function()
    require('gitsigns').setup {
        signs = {
            add          = { text = '▎' },
            change       = { text = '▎' },
            delete       = { text = '▎' },
            topdelete    = { text = '▎' },
            changedelete = { text = '▎' },
        }
    }
end

vim.cmd [[set signcolumn=no]]

return M
