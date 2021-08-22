local actions = require('telescope.actions')

local m = {
    ["<c-d>"] = actions.delete_buffer,
    ["<c-k>"] = actions.move_selection_previous,
    ["<c-j>"] = actions.move_selection_next
}

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            ".git"
        },
        prompt_prefix = '$ ',
        mappings = {
            i = m,
            n = m
        }
    }
}
