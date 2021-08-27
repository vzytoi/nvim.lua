local nest = require('nest')

vim.g.mapleader =  ' '

nest.defaults = {
    mode = 'n',
    prefix = '',
    options = {
        noremap = true,
        silent = true,
    },
}

local setups = {
    'telescope', 'coc', 'term' }

local setJ = {}

for _, s in ipairs(setups) do
    table.insert(setJ, require('plugins.' .. s).setup()[1])
end

nest.applyKeymaps {
    setJ,
    { '<c-h>', '<c-w>W' },
    { '<c-j>', '<c-w>j' },
    { '<c-k>', '<c-w>k' },
    { '<c-l>', '<c-w>w' },
    { '<c-c>', '<esc>' },
    { '<', '<<' },
    { '>', '>>' },
    { '<Tab>', ':tabNext<cr>' },
    { '<S-Tab>', ':tabprevious<cr>' },
    { '<leader>', {
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
        { 'q>', ':x<cr>' }
    }},
    { 'U', '<c-r>' },
}

function _G.termMap()

    local opts = { noremap = true }

    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<leader>t', [[<C-\><C-n>:q!<cr>]], opts)

end

function _G.resize_window(k)

    local wcount = vim.fn.winnr('$')
    local wcurr = vim.fn.winnr()

    local sl = {}
    sl.left = '-'
    sl.right = '+'

    function reverse(s)
        return (s == '-' and '+' or '-')
    end

    function exec(d, s)
        local c = d .. 'res ' .. s .. '3'
        vim.api.nvim_command(c)
    end

    local s

    if sl[k] ~= nil then
        if wcurr == wcount then
            s = reverse(sl[k])
        else
            s = sl[k]
        end
        exec('vert ', s)
    else
        sl.up = sl.right
        sl.down = sl.left
        exec('', sl[k])
    end

end

local opts = { noremap = true }

vim.api.nvim_set_keymap('n', '<a-h>', ':lua resize_window("left")<cr>', opts)
vim.api.nvim_set_keymap('n', '<a-l>', ':lua resize_window("right")<cr>', opts)
vim.api.nvim_set_keymap('n', '<a-k>', ':lua resize_window("up")<cr>', opts)
vim.api.nvim_set_keymap('n', '<a-j>', ':lua resize_window("down")<cr>', opts)
