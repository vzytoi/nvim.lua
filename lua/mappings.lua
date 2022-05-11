local M = {}

M.nest = require("nest")
M.utils = require("utils")
M.luasnip = require('luasnip')
M.cmp = require('cmp')

function M.config()

    vim.g.mapleader = " "

    require("plugins.runcode").setup()
    require("plugins.resize").setup()
    require("plugins.term").setup()
    require("plugins.tree").setup()

    M.nest.applyKeymaps {
        {
            "<c-",
            {
                { "h>", "<c-w>W" },
                { "j>", "<c-w>j" },
                { "k>", "<c-w>k" },
                { "l>", "<c-w>w" },
                { "q>", ":x<cr>" }
            }
        },
        { "<", "<<" },
        { ">", ">>" },
        { "<Tab>", ":tabNext<cr>" },
        { "<S-Tab>", ":tabprevious<cr>" },
        {
            "<leader>",
            {
                { "g", ":DogeGenerate<cr>" },
                { "z", ":ZenMode<cr>" },
                { "u", ":PP<cr>" },
                {
                    "q",
                    {
                        { "s", [[<cmd>lua require("persistence").load()<cr>]] },
                        { "l", [[<cmd>lua require("persistence").load({ last = true })<cr>]] },
                        { "d", [[<cmd>lua require("persistence").stop()<cr>]] }
                    }
                },
                { "n", ":silent set rnu!<cr>" },
                {
                    "c",
                    {
                        { "h", ":cnext<cr>" },
                        { "l", ":cprevious<cr>" }
                    }
                },
                {
                    "y",
                    {
                        { "l", 'V"*y' },
                        { "a", ":%y+<cr>" }
                    }
                },
                {
                    "q",
                    {
                        { "o", ":copen<cr>" },
                        { "c", ":cclose<cr>" },
                        { "k", ":cprev<cr>" },
                        { "j", ":cnext<cr>" }
                    }
                },
                { "b", ":buffers<cr>" },
                {
                    "b",
                    {
                        { "k", ":b#<cr>" },
                        { "h", ":bNext<cr>" },
                        { "l", ":bprevious<cr>" },
                        {
                            "d",
                            {
                                { "k", ":b#|bd #<cr>" }
                            }
                        },
                        {
                            "v",
                            {
                                { "k", ":vsp|b#<cr>" },
                                { "h", ":vsp|bNext<cr>" },
                                { "l", ":vsp|bprevious<cr>" }
                            }
                        },
                        {
                            "s",
                            {
                                { "k", ":sp|b#<cr>" },
                                { "h", ":sp|bNext<cr>" },
                                { "l", ":sp|bprevious<cr>" }
                            }
                        }
                    }
                },
                {
                    "i",
                    {
                        { "n", ":normal! gg=G<cr><c-o>" }
                    }
                },
                { "o", "o<Esc>" },
                { "O", "O<Esc>" },
                {
                    "g",
                    {
                        { "s", ":G|20wincmd_<cr>" },
                        { "c", ":G commit|star<cr>" },
                        { "p", ":G push<cr>" },
                        { "l", ":G log<cr>" },
                        { "d", ":Gdiff<cr>" },
                        { "q", ":q<cr>" }
                    }
                }
            }
        },
        { "n", "nzzzv" },
        { "N", "Nzzzv" },
        { "J", "mzJ`z" },
        {
            mode = "v",
            {
                {
                    options = { noremap = false },
                    {
                        { "H", "<Plug>(MvVisLeft)" },
                        { "J", "<Plug>(MvVisDown)=gv" },
                        { "K", "<Plug>(MvVisUp)=gv" },
                        { "L", "<Plug>(MvVisRight)" }
                    }
                },
                { "<", "<gv" },
                { ">", ">gv" },
                { "y", '"*y' }
            }
        },
        {
            mode = "i",
            {
                {
                    "<c-",
                    {
                        { "j>", "<c-n>" },
                        { "k>", "<c-p>" },
                        { "c>", "<esc>" }
                    }
                }
            }
        }
    }

    vim.keymap.set("n", "<leader>r",
        function()
            require("telescope").extensions.refactoring.refactors()
        end,
        M.utils.opts
    )

    vim.keymap.set("n", "<leader>d",
        function()
            M.utils.toggle("DiffviewOpen", "DiffviewClose")
        end,
        M.utils.opts
    )

    vim.keymap.set("n", "<leader>l",
        function()
            M.utils.toggle("lop", "lcl")
        end,
        M.utils.opts
    )

    vim.keymap.set("n", "<leader>c",
        function()
            M.utils.toggle("copen", "cclose")
        end,
        M.utils.opts
    )

    -- if M.luasnip and M.luasnip.expand_or_jumpable() then

    vim.keymap.set("i", "<a-s>", "<Plug>luasnip-expand-or-jump")

end

return M
