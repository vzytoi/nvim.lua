local nest = require('nest')

nest.defaults = {
    mode = 'n',
    prefix = '',
    options = {
        noremap = true,
        silent = true,
    },
}

vim.g.mapleader =  ' '

nest.applyKeymaps {
    { 'H', '<c-w>W' },
    { 'J', '<c-w>j' },
    { 'K', '<c-w>k' },
    { 'L', '<c-w>w' },
    { '<', '<<' },
    { '>', '>>' },
    { '<leader>', {
        { 'f', '<Cmd>Telescope git_files<cr>' },
        { 'f', {
            { 'g', '<Cmd>Telescope live_grep<CR>' },
            { 'b', '<Cmd>Telescope buffers<CR>' }
        }},
        { 'b', {
            { 'd', ':normal gg=G<cr><c-o>' },
            { 'c', ':CocCommand prettier.formatFile<cr>' }
        }},
        { 'e', ':CocCommand explorer<cr>' },
        { 'o', 'o<Esc>' },
        { 'O', 'O<Esc>' },
        { 'g', {
            { 'd', '<Plug>(coc-definition)', options = { noremap = false } },
            { 'f', '<Plug>(coc-references)', options = { noremap = false } },
            { 'r', '<Plug>(coc-rename)', options = { noremap = false } },
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
    }}
}
