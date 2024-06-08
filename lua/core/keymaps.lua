local M = {}

local nest = require("nest")
local neogit = require("neogit")
local runcode = require("runcode")
local treesj = require("treesj")
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local persistence = require("persistence")
local trouble = require("trouble")

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
        { "<",       "<<" },
        { ">",       ">>" },
        { "<Left>",  ":SidewaysLeft<cr>" },
        { "<Right>", ":SidewaysRight<cr>" },
        { "<Tab>",   ":tabnext<cr>" },
        { "<S-Tab>", ":tabprevious<cr>" },
        { "<Space>", "<Nop>" },
        { "Ì",       function() resize.resize_left(5) end },
        { "¬",       function() resize.resize_right(5) end },
        { "È",       function() resize.resize_up(5) end },
        { "gt",      function() treesj.toggle() end },
        { "Ï",       function() resize.resize_down(5) end },
        { "gt",      function() treesj.toggle() end },
        { "<leader>", {
            { "s",   function() require("dropbar.api").pick() end },
            { "k",   function() harpoon_ui.nav_next() end },
            { "apm", function() require("vim-apm"):toggle_monitor() end},
            { "tr",  function() trouble.toggle() end },
            { "j",   function() harpoon_ui.nav_prev() end },
            { "fml", "<cmd>CellularAutomaton make_it_rain<CR>" },
            { "ti",  require('quickterm').open },
            { "x",   function() runcode.run() end },
            { "xx",  function() runcode.run { method = "Compile" } end },
            { "xt",  function() runcode.run { dir = "tab" } end },
            { "xv",  function() runcode.run { dir = "vertical" } end },
            { 'gd',  function() u.fun.toggle("DiffviewOpen", "DiffviewClose") end },
            { "h",   function() harpoon_ui.toggle_quick_menu() end },
            { "ha",  function() harpoon_mark.add_file() end },
            { "z",   ":ZenMode<cr>" },
            { "ya",  ":%y+<cr>" },
            { "q", {
                { "s", persistence.load },
                { "l", function() persistence.load({ last = true }) end },
                { "d", function() persistence.stop() end }
            } },
            { "q", {
                { "k", ":cprev<cr>" },
                { "j", ":cnext<cr>" }
            } },
            { "g", ":Neogit kind=split<cr>" },
            { "g",
                { "c", function() neogit.open({ "commit" }) end } },
        } },
        { "n", "nzzzv" },
        { "N", "Nzzzv" },
        { "J", "mzJ`z" },
        {
            mode = "v",
            {
                { 'L', ":MoveHBlock(1)<CR>" },
                { 'J', ":MoveBlock(1)<CR>" },
                { 'K', ":MoveBlock(-1)<CR>" },
                { 'H', ":MoveHBlock(-1)<CR>" },
                { "<", "<gv" },
                { ">", ">gv" },
            }
        },
        {
            mode = "i",
            {
                { "kj", "<c-c>" },
                { "<c-", {
                    { "j>", "<c-n>" },
                    { "k>", "<c-p>" },
                    { "c>", "<esc>" }
                } },
            }
        }
    }

    for k, v in pairs(u.fun.keycount) do
        vim.g.nmap("<leader>" .. k, function()
            if vim.fn.tabpagenr('$') >= v then
                vim.api.nvim_command("tabn" .. v)
            else
                vim.api.nvim_command('tabnew')
            end
        end)

        vim.g.nmap("<leader>h" .. k, function()
            harpoon_ui.nav_file(v)
        end)
    end
end

return M
