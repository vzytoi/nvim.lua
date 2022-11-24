local M = {}

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

M.setup = function()

    local ivy = themes.get_ivy({
        show_untracked = true
    })

    vim.g.nmap("<leader>f", function()
        if not pcall(builtin.git_files, ivy) then
            builtin.find_files(themes.get_ivy({ no_ignore = true }))
        end
    end)

    vim.g.nmap("<leader>fg", function()
        builtin.live_grep()
    end)

    vim.g.nmap("<leader>fb",
        function()
            builtin.buffers(themes.get_dropdown({
                previewer = false
            }))
        end)

    vim.g.nmap("<leader>fh", function()
        builtin.help_tags(ivy)
    end)

    vim.g.nmap("<leader>fr", function()
        telescope.extensions.recent_files.pick()
    end)

    vim.g.nmap("<leader>fp", function()
        telescope.extensions.project.project {}
    end)

end

M.config = function()
    telescope.setup({
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 100
            },
            file_ignore_patterns = { ".git/", "_build/" },
            prompt_prefix = "> ",
            selection_caret = "> ",
            sorting_strategy = "ascending",
            color_devicons = true,
            mappings = {
                i = {
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-j>"] = actions.move_selection_next,
                    ['<c-d>'] = actions.delete_buffer
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

    telescope.load_extension('project')
    telescope.load_extension("fzf")
    telescope.load_extension("recent_files")

    M.setup()
end

return M
