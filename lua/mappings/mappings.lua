local M = {}

function M.setup()

    return {
        { '<c-', {
            { 'h>', '<c-w>W' },
            { 'j>', '<c-w>j' },
            { 'k>', '<c-w>k' },
            { 'l>', '<c-w>w' },
            { 'q>', ':x<cr>' }
        }},
        { '<', '<<' },
        { '>', '>>' },
        { '<Tab>', ':tabNext<cr>' },
        { '<S-Tab>', ':tabprevious<cr>' },
        { '<leader>', {
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
            { options = { noremap = false}, {
                { 'H', '<Plug>(MvVisLeft)' },
                { 'J', '<Plug>(MvVisDown)=gv' },
                { 'K', '<Plug>(MvVisUp)=gv' },
                { 'L', '<Plug>(MvVisRight)' },
            }},
            { '<', '<gv' },
            { '>', '>gv' },
            { 'y', '"*y'}
        }},
        { mode = 'i', {
            { '<c-', {
                { 'j>', '<c-n>'},
                { 'k>', '<c-p>'},
            }},
            { options = { expr = true}, {
                { '<TAB>', [[pumvisible() ? "\<C-y>" : "\<Tab>" ]] }
            }}
        }},
    }

end

return M
