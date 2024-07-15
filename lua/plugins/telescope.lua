local M = {}


M.keymaps = function()
    local _, telescope = pcall(require, 'telescope')
    local _, builtin = pcall(require, "telescope.builtin")
    local _, themes = pcall(require, "telescope.themes")

    local ivy = themes.get_ivy({
        show_untracked = true,
        no_ignore = true
    })

    local dp = themes.get_dropdown({
        show_untracked = true,
        no_ignore = true,
        previewer = false
    })

    vim.keymap.set("n", "<leader>fb", function() builtin.buffers(dp) end)
    vim.keymap.set("n", "<leader>fg", function() builtin.live_grep(ivy) end)
    vim.keymap.set("n", "<leader>f", function() builtin.find_files(ivy) end)
    vim.keymap.set("n", "<leader>fh", function() builtin.help_tags(dp) end)
    vim.keymap.set("n", "<leader>fr", function() telescope.extensions.recent_files.pick() end)
    vim.keymap.set("n", "<leader>fp", function() telescope.extensions.projects.projects(dp) end)
end

M.load = {
    "nvim-telescope/telescope.nvim",
    config = function()
        require("plugins.telescope").config()
    end,
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end
        },
        {
            "smartpde/telescope-recent-files",
            config = function()
                require("telescope").load_extension("recent_files")
            end
        },
        {
            "ahmedkhalf/project.nvim",
            config = function()
                require("telescope").load_extension("projects")
                require("project_nvim").setup {
                    detection_methods = { "pattern" },
                }
            end
        },

    },
}

M.config = function()
    local _, telescope = pcall(require, 'telescope')
    local _, actions = pcall(require, "telescope.actions")

    telescope.setup({
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 100
            },
            file_ignore_patterns = { ".git/", "_build/", "%.pdf", "lazy%-lock%.json", "%.ttf", "%.DS%_Store", "sessions/" },
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
end

return M
