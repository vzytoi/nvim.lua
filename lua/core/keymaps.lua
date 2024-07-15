local M = {}

local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local resize = require("smart-splits")
local neogit = require("neogit")

M.config = function()
    require "plugins.toggleterm".keymaps()
    require "plugins.nvimtree".keymaps()
    require "plugins.lsp".keymaps()
    require "plugins.telescope".keymaps()

    vim.keymap.set("n", "<", "<<")
    vim.keymap.set("n", ">", ">>")
    vim.keymap.set("v", "<", "<gv")
    vim.keymap.set("v", ">", ">gv")
    vim.keymap.set("i", "<c-c>", "<esc>l")

    vim.keymap.set("n", "<leader>h", harpoon_ui.toggle_quick_menu)
    vim.keymap.set("n", "ha", harpoon_mark.add_file)
    for k, v in pairs(u.fun.keycount) do
        vim.keymap.set("n", "<leader>" .. k, function()
            harpoon_ui.nav_file(v)
        end)
    end

    vim.keymap.set("n", "<C-h>", "<c-w>h")
    vim.keymap.set("n", "<C-j>", "<c-w>j")
    vim.keymap.set("n", "<C-k>", "<c-w>k")
    vim.keymap.set("n", "<C-l>", "<c-w>l")

    vim.keymap.set("n", "Ì", function() resize.resize_left(5) end)
    vim.keymap.set("n", "¬", function() resize.resize_right(5) end)
    vim.keymap.set("n", "È", function() resize.resize_up(5) end)
    vim.keymap.set("n", "Ï", function() resize.resize_down(5) end)

    vim.keymap.set("v", "L", ":MoveHBlock(1)<CR>")
    vim.keymap.set("v", "J", ":MoveBlock(1)<CR>")
    vim.keymap.set("v", "K", ":MoveBlock(-1)<CR>")
    vim.keymap.set("v", "H", ":MoveHBlock(-1)<CR>")

    vim.keymap.set("n", "<leader>g", function() neogit.open({ kind = "split" }) end)


    vim.keymap.set("n", 'gd', function() u.fun.toggle("DiffviewOpen", "DiffviewClose") end)
end

return M
