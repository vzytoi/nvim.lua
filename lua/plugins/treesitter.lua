require('nvim-treesitter.configs').setup({
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        use_language_tree = true
    },
    indent = {
        enable = true
    },
    autopairs = {
        enable = true
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
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})
