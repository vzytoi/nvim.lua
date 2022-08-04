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

    require("plugins.runcode").keymaps()
    require("plugins.resize").keymaps()
    require("plugins.toggleterm").keymaps()
    require("plugins.nvimtree").keymaps()
    require("plugins.lsp").keymaps()

    nest.applyKeymaps {
        { "<c-", {
            { "h>", "<c-w>W" },
            { "j>", "<c-w>j" },
            { "k>", "<c-w>k" },
            { "l>", "<c-w>w" },
            { "c>", "<esc>" },
        } },
        { "<", "<<" },
        { ">", ">>" },
        { 'gs', '<cmd>Pounce<cr>' },
        { "<Tab>", ":tabNext<cr>" },
        { "<S-Tab>", ":tabprevious<cr>" },
        { "<leader>", {
            { "h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },
            { "h", {
                { "a", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
            } },
            { "w", ":silent write<cr>" },
            { "p", ":PP<cr>" },
            { "z", ":ZenMode<cr>" },
            { "ya", ":%y+<cr>" },
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
                { "k", ":cprev<cr>" },
                { "j", ":cnext<cr>" }
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
        vim.func.toggle("DiffviewOpen", "DiffviewClose")
    end)

    vim.g.nmap("<leader>l", function()
        vim.func.toggle("lop", "lcl")
    end)

    vim.g.nmap("<leader>c", function()
        vim.func.toggle("copen", "cclose")
    end)

    vim.g.nmap("<leader>s", require('spectre').open)

    for k, v in pairs(vim.func.keycount) do
        vim.g.nmap("<leader>" .. k, function()
            if vim.fn.tabpagenr('$') >= v then
                vim.api.nvim_command("tabn" .. v)
            else
                vim.api.nvim_command('tabnew')
            end
        end)

        vim.g.nmap("<leader>h" .. k, function()
            require('harpoon.ui').nav_file(v)
        end)
    end

end

return M
