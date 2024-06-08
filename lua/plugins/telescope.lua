local M = {}

M.load = {
    "nvim-telescope/telescope.nvim",
    config = function()
        require("plugins.telescope").config()
    end,
    keys = "<leader>f",
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
                    exclude_dirs = {"/Users/Cyprien"}
                }
            end
        },

    },
}

M.setup = function()
    local _, telescope = pcall(require, 'telescope')
    local _, builtin = pcall(require, "telescope.builtin")
    local _, themes = pcall(require, "telescope.themes")

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
        require'telescope'.extensions.projects.projects(themes.get_dropdown())
    end)

    vim.keymap.set("n", "<leader>ft", function()
        builtin.treesitter(themes.get_ivy())
    end)

    vim.keymap.set("n", "<leader>fs", function()
        builtin.lsp_workspace_symbols(themes.get_ivy())
    end)
end

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

    M.setup()
end

return M
