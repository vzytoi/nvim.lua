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
    'telescope', 'coc' }

local setJ = {}

for _, s in ipairs(setups) do
    table.insert(setJ, require('plugins.' .. s).setup()[1])
end


nest.applyKeymaps {
    setJ,
    { 'H', '<c-w>W' },
    { 'J', '<c-w>j' },
    { 'K', '<c-w>k' },
    { 'L', '<c-w>w' },
    { '<', '<<' },
    { '>', '>>' },
    { '<leader>', {
        { 'b', {
            { 'd', ':normal gg=G<cr><c-o>' },
        }},
        { 't', {
            { 'f', ':ToggleTerm direction=float<cr>' },
            { 'h', ':ToggleTerm direction=horizontal<cr>' },
            { 'v', ':ToggleTerm direction=vertical<cr>' }
        }},
        { 't', ':ToggleTerm direction=window<cr>' },
        { 'e', ':CocCommand explorer<cr>' },
        { 'o', 'o<Esc>' },
        { 'O', 'O<Esc>' },
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
    }}
}

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'H', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'J', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'K', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'L', [[<C-\><C-n><C-W>l]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<leader>t', [[<C-\><C-n>:q!<cr>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
