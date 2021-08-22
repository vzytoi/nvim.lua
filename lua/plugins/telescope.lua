local M = {}

function M.t()
    print('salut!')
end

function M.setup()

    local map = {
        { '<leader>', {
            { 'f', '<Cmd>Telescope git_files theme=get_ivy<cr>' },
            { 'f', {
                { 'g', '<Cmd>Telescope live_grep theme=get_ivy<CR>' },
                { 'b', '<Cmd>Telescope buffers theme=get_ivy<CR>' }
            }},
        }}
    }

    return map

end

function M.config()

    local actions = require 'telescope.actions'

    require('telescope').setup {
        defaults = {
            file_ignore_patterns = {
                ".git/*"
            },
            prompt_prefix = '> ',
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer,
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-j>"] = actions.move_selection_next
                },
                n = {
                    ["<Esc>"] = actions.close
                }
            }
        },
    }

end


return M
