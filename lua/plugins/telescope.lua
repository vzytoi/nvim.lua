local M = {}

M.telescope = require("telescope")
M.builtin = require("telescope.builtin")
M.actions = require("telescope.actions")
M.themes = require("telescope.themes")
M.utils = require("utils")

function M.setup_tmp()
    local ivy =
    M.themes.get_ivy(
        {
        show_untracked = true
    }
    )

    vim.keymap.set("n", "<leader>f",
        function()
            if not pcall(M.builtin.git_files, ivy) then
                M.builtin.find_files(ivy)
            end
            print("called")
        end,
        M.builtin.opts
    )

    vim.keymap.set(
        "n",
        "<leader>fg",
        function()
            M.builtin.live_grep(ivy)
        end,
        M.builtin.opts
    )

    vim.keymap.set("n", "<leader>fb",
        function()
            M.builtin.buffers(ivy)
        end,
        M.builtin.opts
    )

    vim.keymap.set("n", "<leader>fb",
        function()
            M.builtin.buffers(ivy)
        end,
        M.builtin.opts
    )

    vim.keymap.set("n", "<leader>fh",
        function()
            M.builtin.help_tags(ivy)
        end,
        M.builtin.opts
    )

    vim.keymap.set("n", "<leader>ft",
        function()
            M.builtin.grep_string {
                prompt_prefix = "Search toods > ",
                search = " TODO:",
                file_ignore_patterns = {
                    "snips/*"
                }
            }
        end,
        M.builtin.opts
    )

    vim.keymap.set( "n", "<leader>fn",
        function()
            M.builtin.git_files {
                prompt_prefix = "Neovim > ",
                cwd = "~/.config/nvim"
            }
        end,
        M.builtin.opts
    )
end

function M.config()
    M.telescope.setup(
        {
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 500
            },
            file_ignore_patterns = {
                ".git/*"
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
                    ["<c-k>"] = M.actions.move_selection_previous,
                    ["<c-j>"] = M.actions.move_selection_next
                },
                n = {
                    ["<Esc>"] = M.actions.close
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

    M.telescope.load_extension("fzf")
    M.telescope.load_extension("refactoring")
end

return M
