local M = {}

M.load = {
    "nvim-treesitter/nvim-treesitter",
    config       = function()
        require("plugins.treesitter").config()
    end,
    lazy         = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-textsubjects",
        "nvim-treesitter/nvim-tree-docs",
        "nvim-treesitter/nvim-tree-docs",
        {
            "abecodes/tabout.nvim",
            lazy = true,
            event = "VeryLazy",
            config = function()
                require("tabout").setup()
            end,
        },
    },
    event        = "BufWinEnter"
}

M.autocmds = function()
    vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
            local size = vim.fn.getfsize(vim.fn.expand("%"))

            if size >= 1000000 then
                for hl_name, _ in pairs(vim.api.nvim_get_hl_defs(0)) do
                    vim.api.nvim_set_hl(0, hl_name, {})
                end
            elseif size >= 100 * 1024 then -- 100 KB
                vim.api.nvim_command("TSBufDisable highlight")
            elseif vim.g.TS_disabled then
                vim.api.nvim_command("TSBufEnable highlight")
            end

            vim.g.TS_disabled = size >= 500000
        end
    })
end

M.config = function()
    require("nvim-treesitter.configs").setup({
        autopairs = { enable = true },
        autotag = { enable = true },
        tree_docs = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        context_commenstring = { enable = true },
        highlight = { enable = true, disable = { "NeogitCommitMessage", "help" } },
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
        },
        disable = function(_, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 50000
        end
    })
end

return M
