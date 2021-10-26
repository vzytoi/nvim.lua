local resize = require("plugins.resize").commands()
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
        "term",
        "runcode"
    }

    local map = {}

    for _, s in ipairs(setups) do
        table.insert(map, require("plugins." .. s).setup()[1])
    end

    return map

end

function StopUndo()

    local keys = {
        ',', ';', '?', '.', '!', ':'
    }

    local map = {mode = 'i', {}}

    for _, v in ipairs(keys) do
        table.insert(map[1], {v, v .. '<c-g>u'})
    end

    return map

end

function _G.termMap()

    local opts = {noremap = true}

    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<leader>t", [[<C-\><C-n>:q!<cr>]], opts)

end

nest.applyKeymaps {

    { '<c-', {
        { 'h>', '<c-w>W' },
        { 'j>', '<c-w>j' },
        { 'k>', '<c-w>k' },
        { 'l>', '<c-w>w' },
        { 'q>', ':x<cr>' }
    }},
    { '<a-', {
        { 'h>', ':Resizeleft<CR>'},
        { 'l>', ':Resizeright<CR>'},
        { 'k>', ':Resizeup<CR>'},
        { 'j>', ':Resizedown<CR>'}
    }},
    { '<', '<<' },
    { '>', '>>' },
    { '<Tab>', ':tabNext<cr>' },
    { '<S-Tab>', ':tabprevious<cr>' },
    { '<leader>', {
        { 'aa', function() print('ok') end },
        { 'c', ':Cheat<cr>'},
        { 'c', {
            { 'l', ':CheatList<cr>'}
        }},
        { 'y', {
            { 'l', 'V"*y' },
            { 'a', 'ggVG"*y<c-o>'}
        }},
        { 'q', {
            { 'o', ':copen<cr>' },
            { 'c', ':cclose<cr>' },
            { 'k', ':cprev<cr>' },
            { 'j', ':cnext<cr>' }
        }},
        { 'b', {
            { 'k', ':b#<cr>' },
            { 'h', ':bNext<cr>' },
            { 'l', ':bprevious<cr>' },
            { 'd', {
                { 'k', ':b#|bd #<cr>'}
            }},
            { 'v', {
                { 'k', ':vsp|b#<cr>' },
                { 'h', ':vsp|bNext<cr>' },
                { 'l', ':vsp|bprevious<cr>' },
            }},
            { 's', {
                { 'k', ':sp|b#<cr>' },
                { 'h', ':sp|bNext<cr>' },
                { 'l', ':sp|bprevious<cr>' },
            }}
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
            { 'l', ':G log<cr>' },
            { 'd', ':Gdiff<cr>' }
        }},
    }},
    { 'n', 'nzzzv' },
    { 'N', 'Nzzzv' },
    { 'J', 'mzJ`z'},
    { mode  = 'v', {
        { 'H', '<Plug>(MvVisLeft)', options = { noremap = false } },
        { 'J', '<Plug>(MvVisDown)=gv', options = { noremap = false } },
        { 'K', '<Plug>(MvVisUp)=gv', options = { noremap = false } },
        { 'L', '<Plug>(MvVisRight)', options = { noremap = false } },
        { '<', '<gv' },
        { '>', '>gv' },
        { 'y', '"*y'}
    }},
    { mode = 'i', {
        { '<c-j>', '<c-n>'},
        { '<c-k>', '<c-p>'},
    }},
    QueryMapping(),
    StopUndo()
}

local opts = {noremap = true, silent=true}

vim.cmd([[inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<Tab>"]])
