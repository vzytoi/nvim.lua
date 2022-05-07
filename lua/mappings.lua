local M = {}

M.nest = require("nest")

local var = {"copen", "DiffviewOpen", "lop"}

for _, v in pairs(var) do
    vim.g[v] = false
end

local function toggle(open, close)
    vim.api.nvim_command((vim.g[open] and close or open))

    return not vim.g[open]
end

function M.config()
    require("plugins.runcode").setup()
    require("plugins.resize").setup()
    require("plugins.term").setup()

    M.nest.applyKeymaps {
        {
            "<c-",
            {
                {"h>", "<c-w>W"},
                {"j>", "<c-w>j"},
                {"k>", "<c-w>k"},
                {"l>", "<c-w>w"},
                {"q>", ":x<cr>"},
                {"c>", "<esc>"}
            }
        },
        {"<", "<<"},
        {">", ">>"},
        {"<Tab>", ":tabNext<cr>"},
        {"<S-Tab>", ":tabprevious<cr>"},
        {
            "<leader>",
            {
                {"g", ":DogeGenerate<cr>"},
                {"z", ":ZenMode<cr>"},
                {"u", ":PP<cr>"},
                {
                    "d",
                    function()
                        vim.g.DiffviewOpen = toggle("DiffviewOpen", "DiffviewClose")
                    end
                },
                {
                    "q",
                    {
                        {"s", [[<cmd>lua require("persistence").load()<cr>]]},
                        {"l", [[<cmd>lua require("persistence").load({ last = true })<cr>]]},
                        {"d", [[<cmd>lua require("persistence").stop()<cr>]]}
                    }
                },
                {"n", ":silent set rnu!<cr>"},
                {"h", ":Cheat<cr>"},
                {
                    "h",
                    {
                        {"l", ":CheatList<cr>"}
                    }
                },
                {
                    "l",
                    function()
                        vim.g.lop = toggle("lop", "lcl")
                    end
                },
                {
                    "c",
                    function()
                        vim.g.copen = toggle("copen", "cclose")
                    end
                },
                {
                    "c",
                    {
                        {"h", ":cnext<cr>"},
                        {"l", ":cprevious<cr>"}
                    }
                },
                {
                    "y",
                    {
                        {"l", 'V"*y'},
                        {"a", ":%y+<cr>"}
                    }
                },
                {
                    "q",
                    {
                        {"o", ":copen<cr>"},
                        {"c", ":cclose<cr>"},
                        {"k", ":cprev<cr>"},
                        {"j", ":cnext<cr>"}
                    }
                },
                {"b", ":buffers<cr>"},
                {
                    "b",
                    {
                        {"k", ":b#<cr>"},
                        {"h", ":bNext<cr>"},
                        {"l", ":bprevious<cr>"},
                        {
                            "d",
                            {
                                {"k", ":b#|bd #<cr>"}
                            }
                        },
                        {
                            "v",
                            {
                                {"k", ":vsp|b#<cr>"},
                                {"h", ":vsp|bNext<cr>"},
                                {"l", ":vsp|bprevious<cr>"}
                            }
                        },
                        {
                            "s",
                            {
                                {"k", ":sp|b#<cr>"},
                                {"h", ":sp|bNext<cr>"},
                                {"l", ":sp|bprevious<cr>"}
                            }
                        }
                    }
                },
                {
                    "i",
                    {
                        {"n", ":normal! gg=G<cr><c-o>"}
                    }
                },
                {"o", "o<Esc>"},
                {"O", "O<Esc>"},
                {
                    "g",
                    {
                        {"s", ":G|20wincmd_<cr>"},
                        {"c", ":G commit|star<cr>"},
                        {"p", ":G push<cr>"},
                        {"l", ":G log<cr>"},
                        {"d", ":Gdiff<cr>"},
                        {"q", ":q<cr>"}
                    }
                }
            }
        },
        {"n", "nzzzv"},
        {"N", "Nzzzv"},
        {"J", "mzJ`z"},
        {
            mode = "v",
            {
                {
                    options = {noremap = false},
                    {
                        {"H", "<Plug>(MvVisLeft)"},
                        {"J", "<Plug>(MvVisDown)=gv"},
                        {"K", "<Plug>(MvVisUp)=gv"},
                        {"L", "<Plug>(MvVisRight)"}
                    }
                },
                {"<", "<gv"},
                {">", ">gv"},
                {"y", '"*y'}
            }
        },
        {
            mode = "i",
            {
                {
                    "<c-",
                    {
                        {"j>", "<c-n>"},
                        {"k>", "<c-p>"}
                    }
                }
            }
        }
    }
end

return M
