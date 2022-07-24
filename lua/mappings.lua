local M = {}

local fn = require("fn")
local nest = fn.lazy_require("nest")

function M.config()

    require("plugins.runcode").setup()
    require("plugins.resize").setup()
    require("plugins.term").setup()
    require("plugins.tree").setup()

    nest.applyKeymaps {
        { "<c-", {
            { "h>", "<c-w>W" },
            { "j>", "<c-w>j" },
            { "k>", "<c-w>k" },
            { "l>", "<c-w>w" },
            { "q>", ":x<cr>" }
        } },
        { "<", "<<" },
        { ">", ">>" },
        { "~", "~h" },
        { "<Tab>", ":tabNext<cr>" },
        { "<S-Tab>", ":tabprevious<cr>" },
        { "<leader>", {
            { "p", ":PP<cr>" },
            { "o", ":MaximizerToggle<cr>" },
            { "g", ":DogeGenerate<cr>" },
            { "z", ":ZenMode<cr>" },
            { "ya", ":%y+<cr>" },
            { "n", ":silent set rnu!<cr>" },
            { 'b', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },
            { 'b', {
                { 'a', "<cmd>lua require('harpoon.mark').add_file()<cr>" }
            } },
            { "q", {
                { "s", [[<cmd>lua require("persistence").load()<cr>]] },
                { "l", [[<cmd>lua require("persistence").load({ last = true })<cr>]] },
                { "d", [[<cmd>lua require("persistence").stop()<cr>]] }
            } },
            { "c", {
                { "h", ":cnext<cr>" },
                { "l", ":cprevious<cr>" }
            } },
            { "q", {
                { "o", ":copen<cr>" },
                { "c", ":cclose<cr>" },
                { "k", ":cprev<cr>" },
                { "j", ":cnext<cr>" }
            } },
            { "b", {
                { "k", ":b#<cr>" },
                { "h", ":bNext<cr>" },
                { "l", ":bprevious<cr>" },
                { "d", {
                    { "k", ":b#|bd #<cr>" }
                } },
                { "v", {
                    { "k", ":vsp|b#<cr>" },
                    { "h", ":vsp|bNext<cr>" },
                    { "l", ":vsp|bprevious<cr>" }
                } },
                { "s", {
                    { "k", ":sp|b#<cr>" },
                    { "h", ":sp|bNext<cr>" },
                    { "l", ":sp|bprevious<cr>" }
                } }
            } },
            { "i", {
                { "n", ":normal! gg=G<cr><c-o>" }
            } },
            { "g", {
                { "s", ":G|20wincmd_<cr>" },
                { "c", ":G commit|star<cr>" },
                { "p", ":G push<cr>" },
                { "l", ":G log<cr>" },
                { "d", ":Gdiff<cr>" },
                { "q", ":q<cr>" }
            } }
        } },
        { "n", "nzzzv" },
        { "N", "Nzzzv" },
        { "J", "mzJ`z" },
        { mode = "v", {
            { 'L', ":MoveHBlock(1)<CR>" },
            { 'J', ":MoveBlock(1)<CR>" },
            { 'K', ":MoveBlock(-1)<CR>" },
            { 'H', ":MoveHBlock(-1)<CR>" },
            { "<", "<gv" },
            { ">", ">gv" },
        } },
        { mode = "i", {
            { "<c-", {
                { "j>", "<c-n>" },
                { "k>", "<c-p>" },
                { "c>", "<esc>" }
            } }
        } }
    }

    vim.keymap.set("n", "<leader>r",
        function()
            require("telescope").extensions.refactoring.refactors()
        end,
        fn.opts
    )

    vim.keymap.set("n", "<leader>d",
        function()
            fn.toggle("DiffviewOpen", "DiffviewClose")
        end,
        fn.opts
    )

    vim.keymap.set("n", "<leader>l",
        function()
            fn.toggle("lop", "lcl")
        end,
        fn.opts
    )

    vim.keymap.set("n", "<leader>c",
        function()
            fn.toggle("copen", "cclose")
        end,
        fn.opts
    )

end

return M
