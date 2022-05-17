local M = {}

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local fn = require("fn")

function M.setup()
    local ivy = themes.get_ivy({
        show_untracked = true
    })

    vim.keymap.set("n", "<leader>f",
        function()
            if not pcall(builtin.git_files, ivy) then
                builtin.find_files(ivy)
            end
            print("called")
        end,
        builtin.opts
    )

    vim.keymap.set(
        "n",
        "<leader>fg",
        function()
            builtin.live_grep()
        end,
        builtin.opts
    )

    vim.keymap.set("n", "<leader>fb",
        function()
            builtin.buffers(ivy)
        end,
        builtin.opts
    )

    vim.keymap.set("n", "<leader>fb",
        function()
            builtin.buffers(ivy)
        end,
        builtin.opts
    )

    vim.keymap.set("n", "<leader>fh",
        function()
            builtin.help_tags(ivy)
        end,
        builtin.opts
    )

    vim.keymap.set("n", "<leader>ft",
        function()
            builtin.grep_string {
                prompt_prefix = "Search toods > ",
                search = " TODO:",
                file_ignore_patterns = {
                    "snippets/*"
                }
            }
        end,
        builtin.opts
    )

    vim.keymap.set("n", "<leader>fn",
        function()
            builtin.git_files {
                prompt_prefix = "Neovim > ",
                cwd = "~/.config/nvim"
            }
        end,
        builtin.opts
    )
end

function M.config()
    M.setup()
    telescope.setup(
        {
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 500
            },
            file_ignore_patterns = {
                ".git/"
            },
            prompt_prefix = "> ",
            selection_caret = "> ",
            sorting_strategy = "ascending",
            color_devicons = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden"
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--type=file", "--hidden", "--smart-case" }
                }
            },
            mappings = {
                i = {
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-j>"] = actions.move_selection_next
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
            }
        }
    }
    )

    telescope.load_extension("fzf")
    telescope.load_extension("refactoring")
end

return M
