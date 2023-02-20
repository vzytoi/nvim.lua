local M = {}

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local telescope = require('telescope')

M.setup = function()
    local ivy = themes.get_ivy({
        show_untracked = true
    })

    vim.keymap.set("n", "<leader>f", function()
        if not pcall(builtin.git_files, ivy) then
            builtin.find_files(themes.get_ivy({ no_ignore = true }))
        end
    end)

    vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep(themes.get_ivy())
    end)

    vim.keymap.set("n", "<leader>fb",
        function()
            builtin.buffers(themes.get_dropdown({
                previewer = false
            }))
        end)

    vim.keymap.set("n", "<leader>fh", function()
        builtin.help_tags(ivy)
    end)

    vim.keymap.set("n", "<leader>fr", function()
        telescope.extensions.recent_files.pick()
    end)

    vim.keymap.set("n", "<leader>fp", function()
        telescope.extensions.project.project(themes.get_dropdown())
    end)

    vim.keymap.set("n", "<leader>ft", function()
        builtin.treesitter(themes.get_ivy())
    end)
end

M.config = function()
    require('telescope').setup({
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 100
            },
            file_ignore_patterns = { ".git/", "_build/", "%.pdf" },
            prompt_prefix = "> ",
            selection_caret = "> ",
            sorting_strategy = "ascending",
            color_devicons = true,
            mappings = {
                i = {
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-d>"] = actions.delete_buffer,
                    ["<c-s>"] = actions.file_split
                },
                n = {
                    ["<Esc>"] = actions.close
                }
            }
        },
        dynamic_preview_title = true,
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            },
            project = {
                hidden_files = true
            }
        },
    })

    M.setup()
end

return M
