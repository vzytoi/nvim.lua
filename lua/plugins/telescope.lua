local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'f', {
                { 'f', '<Cmd>Telescope git_files theme=get_ivy<cr>' },
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
                    ["<c-j>"] = actions.move_selection_next,
                    ["<Esc>"] = actions.close
                },
                n = {
                    ["<Esc>"] = actions.close
                }
            }
        },
    }

end

return M
