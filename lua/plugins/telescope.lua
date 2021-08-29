local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'f', '<Cmd>Telescope git_files theme=get_ivy<cr>' },
            { 'f', {
                { 'g', '<Cmd>Telescope live_grep theme=get_ivy<CR>' },
                { 'b', '<Cmd>Telescope buffers theme=get_ivy<CR>' },
                { 'h', '<Cmd>Telescope help_tags theme=get_ivy<CR>' }
            }},
        }}
    }

    return map

end

function M.config()

    local actions = require "telescope.actions"

    require("telescope").setup {
        defaults = {
            file_ignore_patterns = {
                ".git/*"
            },
            prompt_prefix = "> ",
            mappings = {
                i = {
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-j>"] = actions.move_selection_next
                },
                n = {
                    ["<Esc>"] = actions.close
                }
            },
            file_sorter = require('telescope.sorter').get_fzy_sorter
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        }
    }

    require('telescope').load_extension('fzy_native')

end

return M
