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
    { '<Tab>', ':tabnext' },
    { '<S-Tab>', ':tabprevious' },
    { '<leader>', {
        { 'b', {
            { 'k', ':b#<cr>' },
            { 'h', ':bNext<cr>' },
            { 'l', ':bprevious<cr>' }
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

function _G.resize_window(d)
    local wcount = vim.fn.winnr('$')

    if wcount <= 1 then
        return false
    end

    local wcurr = vim.fn.winnr()

    function resize(c)
        vim.api.nvim_command('vertical resize ' .. c)
    end

    if wcurr == 1 then
        if d == 'left' or wcurr < wcout then
            resize('-10')
        else
            resize('+10')
        end
    elseif wcurr == wcount then
        if d == 'left' then
            resize('+10')
        else
            resize('-10')
        end
    end

end

vim.api.nvim_set_keymap('n', '<left>', ':lua resize_window("left")<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<right>', ':lua resize_window("right")<cr>', {noremap = true})
