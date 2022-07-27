local M = {}

local nest = require("nest")

local map = function(op, outer)

    outer = outer or { silent = true, noremap = true }
    return function(lhs, rhs, opts)

        if type(lhs) ~= "table" then
            lhs = { lhs }
        end

        opts = vim.tbl_extend("force",
            outer,
            opts or {}
        )

        for _, v in pairs(lhs) do
            vim.keymap.set(op or "n", v, rhs, opts)
        end

    end
end

vim.g.nmap = map("n")
vim.g.imap = map("i")
vim.g.vmap = map("v")
vim.g.tmap = map("t")

M.config = function()

    vim.g.mapleader = " "

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
            { "g", ":DogeGenerate<cr>" },
            { "z", ":ZenMode<cr>" },
            { "ya", ":%y+<cr>" },
            { "n", ":silent set rnu!<cr>" },
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

    vim.g.nmap("<leader>d", function()
        vim.g.fn.toggle("DiffviewOpen", "DiffviewClose")
    end)

    vim.g.nmap("<leader>l", function()
        vim.g.fn.toggle("lop", "lcl")
    end)

    vim.g.nmap("<leader>c", function()
        vim.g.fn.toggle("copen", "cclose")
    end)

    vim.g.nmap("<leader>s", function()
        require('spectre').open()
    end)

end

return M
