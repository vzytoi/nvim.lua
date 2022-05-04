local M = {}

M.setup = function()

    return {
        { '<leader>', {
            { 'e', ':silent! NvimTreeToggle<cr>' }
        } }
    }

end

M.config = function()

    require 'nvim-tree'.setup {
        view = {
            side = 'right',
            mappings = {
                list = {
                    { key = 'v', action = 'vsplit' },
                    { key = 's', action = 'split' },
                    { key = 'e', action = 'edit' }
                }
            }
        },
        git = {
            ignore = false
        }
    }

end

return M
