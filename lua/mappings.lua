local nest = require("nest")

vim.g.mapleader = " "

nest.defaults = {
    mode = "n",
    prefix = "",
    options = {
        noremap = true,
        silent = true
    }
}

function QueryMapping()

    local setups = {
        "telescope",
        "coc",
        "term"
    }

    local map = {}

    for _, s in ipairs(setups) do
        table.insert(map, require("plugins." .. s).setup()[1])
    end

    return map

end

nest.applyKeymaps {

    { '<c-', {
        { 'h>', '<c-w>W' },
        { 'j>', '<c-w>j' },
        { 'k>', '<c-w>k' },
        { 'l>', '<c-w>w' },
    }},

    { '<', '<<' },
    { '>', '>>' },
    { '<Tab>', ':tabNext<cr>' },
    { '<S-Tab>', ':tabprevious<cr>' },
    { '<leader>', {
        { 'q', {
            { 'o', ':copen<cr>' },
            { 'c', ':cclose<cr>' },
            { 'k', ':cprev<cr>' },
            { 'j', ':cnext<cr>' }
        }},
        { 'b', {
            { 'k', ':b#<cr>' },
            { 'h', ':bNext<cr>' },
            { 'l', ':bprevious<cr>' }
        }},
        { 'i', {
            { 'n', ':normal! gg=G<cr><c-o>'}
        }},
        { 'o', 'o<Esc>' },
        { 'O', 'O<Esc>' },
        { 'g', {
            { 's', ':G|20wincmd_<cr>' },
            { 'c', ':G commit|star<cr>' },
            { 'p', ':G push<cr>' },
            { 'l', ':G log<cr>' }
        }}
    }},
    { mode  = 'v', {
        { 'H', '<Plug>(MvVisLeft)', options = { noremap = false } },
        { 'J', '<Plug>(MvVisDown)=gv', options = { noremap = false } },
        { 'K', '<Plug>(MvVisUp)=gv', options = { noremap = false } },
        { 'L', '<Plug>(MvVisRight)', options = { noremap = false } },
        { '<', '<gv' },
        { '>', '>gv' },
    }},
    { '<c-', {
        { 'q>', ':x<cr>' },
    }},
    { 'U', '<c-r>' },
    QueryMapping(),
}

function _G.termMap()

    local opts = {noremap = true}

    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<leader>t", [[<C-\><C-n>:q!<cr>]], opts)

end

function _G.resize_window(k)

    local wcount = vim.fn.winnr("$")
    local wcurr = vim.fn.winnr()

    local sl = {}
    sl.left = "-"
    sl.right = "+"

    function Reverse(s)
        return (s == "-" and "+" or "-")
    end

    function Exec(d, s)
        local c = d .. "res " .. s .. "5"
        vim.api.nvim_command(c)
    end

    local s

    if sl[k] ~= nil then
        if wcurr == wcount then
            s = Reverse(sl[k])
        else
            s = sl[k]
        end
        Exec("vert ", s)
    else
        sl.up = sl.right
        sl.down = sl.left
        Exec("", sl[k])
    end

end

local opts = {noremap = true}

vim.api.nvim_set_keymap("n", "<a-h>", ':lua resize_window("left")<cr>', opts)
vim.api.nvim_set_keymap("n", "<a-l>", ':lua resize_window("right")<cr>', opts)
vim.api.nvim_set_keymap("n", "<a-k>", ':lua resize_window("up")<cr>', opts)
vim.api.nvim_set_keymap("n", "<a-j>", ':lua resize_window("down")<cr>', opts)
