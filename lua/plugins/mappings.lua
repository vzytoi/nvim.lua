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
    { '<', '<<' },
    { '>', '>>' },
    { '<Tab>', ':tabnext' },
    { '<S-Tab>', ':tabprevious' },
    { '<leader>', {
        { 'b', {
            { 'd', ':normal gg=G<cr><c-o>' },
        }},
        { 'o', 'o<Esc>' },
        { 'O', 'O<Esc>' },
        { 'g', {
            { 's', ':G|20wincmd_<cr>' },
            { 'c', ':G commit<cr>' },
            { 'p', ':G push<cr>' }
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
