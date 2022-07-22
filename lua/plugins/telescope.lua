local M = {}

local fn = require("fn")

local telescope = fn.lazy_require("telescope")
local builtin = fn.lazy_require("telescope.builtin")
local actions = fn.lazy_require("telescope.actions")
local themes = fn.lazy_require("telescope.themes")

vim.g.called0 = true

function M.setup()
    local ivy = themes.get_ivy({
        show_untracked = true
    })

    vim.g.called1 = true
    vim.keymap.set("n", "<leader>f",
        function()
            if not pcall(builtin.git_files, ivy) then
                builtin.find_files(ivy)
            end
            vim.g.called2 = true
        end,
        builtin.opts
    )

    vim.keymap.set("n", "<leader>fg",
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
                search = " :",
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
    telescope.setup({
        defaults = {
            preview = {
                check_mine_type = false,
                timeout = 100
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
                    find_command = { "rg", "--no-ignore", "--files" },
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
    })

    telescope.load_extension("fzf")

    M.setup()
end

return M
