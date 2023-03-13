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
    require "plugins.toggleterm".keymaps()
    require "plugins.dap".keymaps()
    require "plugins.nvimtree".keymaps()
    require "plugins.lsp".keymaps()
    require "core.rooter".keymaps()

    local resize = require("smart-splits")

    nest.applyKeymaps {
        { "<c-", {
            { "h>", "<c-w>W" },
            { "j>", "<c-w>j" },
            { "k>", "<c-w>k" },
            { "l>", "<c-w>w" },
            { "c>", "<esc>" },
        } },
        { "Ì", function() resize.resize_left(5) end },
        { "¬", function() resize.resize_right(5) end },
        { "È", function() resize.resize_up(5) end },
        { "Ï", function() resize.resize_down(5) end },
        { "<",  "<<" },
        { ">",  ">>" },
        { 'gJ', function()
            require('trevj').format_at_cursor()
        end },
        { "<Left>",  ":SidewaysLeft<cr>" },
        { "<Right>", ":SidewaysRight<cr>" },
        { "<Tab>",   ":tabnext<cr>" },
        { "<S-Tab>", ":tabprevious<cr>" },
        { "<Space>", "<Nop>" },
        { "<leader>", {
            { "n",   ":Neogen<CR>" },
            { "fml", "<cmd>CellularAutomaton make_it_rain<CR>" },
            { "ti",  require('quickterm').open },
            { "x",   require('runcode').run },
            { "xx",  function() require('runcode').run { method = "Compile" } end },
            { "xt",  function() require('runcode').run { dir = "tab" } end },
            { "xv",  function() require('runcode').run { dir = "vertical" } end },
            { 'gd', function()
                u.fun.toggle("DiffviewOpen", "DiffviewClose")
            end },
            { 'c', function()
                vim.g.nmap("<leader>c", function()
                    u.fun.toggle("copen", "cclose")
                end)
            end },
            { 'w', function()
                nvim.command("AerialToggle")

                vim.g.nmap('K', function()
                    nvim.command("AerialPrev")
                end, { buffer = 0 })

                vim.g.nmap('J', function()
                    nvim.command("AerialNext")
                end, { buffer = 0 })
            end },
            { 'ck', ':cp<cr>' },
            { 'cj', ':cn<cr>' },
            { "h", function()
                require('harpoon.ui').toggle_quick_menu()
            end },
            { "ha", function()
                require('harpoon.mark').add_file()
            end },
            { "z",  ":ZenMode<cr>" },
            { "ya", ":%y+<cr>" },
            { "q", {
                { "s", require("persistence").load },
                { "l", function() require("persistence").load({ last = true }) end },
                { "d", function() require("persistence").stop() end }
            } },
            { "q", {
                { "k", ":cprev<cr>" },
                { "j", ":cnext<cr>" }
            } },
            { "g", ":Neogit kind=split<cr>" },
            { "g", { "c", ":Neogit commit<cr>" } },
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
            { "<leader>", {
                { "r",
                    { "f", function() require('refactoring').refactor('Extract Function') end },
                    { "v", function() require('refactoring').refactor('Extract Variable') end },
                },
            } }
        } },
        { mode = "i", {
            { "<c-", {
                { "j>", "<c-n>" },
                { "k>", "<c-p>" },
                { "c>", "<esc>" }
            } },
        } }
    }

    for k, v in pairs(u.fun.keycount) do
        vim.g.nmap("<leader>" .. k, function()
            if vim.fn.tabpagenr('$') >= v then
                nvim.command("tabn" .. v)
            else
                nvim.command('tabnew')
            end
        end)

        vim.g.nmap("<leader>h" .. k, function()
            require('harpoon.ui').nav_file(v)
        end)
    end
end

return M
