require("nvim-treesitter.configs").setup(
    {
        autopairs = {enable = true},
        tree_docs = {enable = true},
        context_commenstring = {
            enable = true,
            enable_autocmd = false
        },
        highlight = {
            enable = true,
            use_language_tree = true
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ic"] = "@conditional.inner",
                    ["an"] = "@conditional.outer",
                    ["a/"] = "@comment.outer"
                }
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner"
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner"
                }
            }
        },
        textsubjects = {
            enable = true,
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer"
            }
        }
    }
)
