local M = {}

function M.setup()

    return {
        _general = {
            { 'FileType', 'gitcommit', 'au! BufEnter COMMIT_EDITMSG call setpos(".", [0, 1, 1, 0])' },
            {'BufEnter', '*', 'silent! lcd %:p:h'},
            {'BufWinEnter', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'BufRead', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'VimResized', '*', 'wincmd ='}
        },
        _markdown = {
            {'FileType', 'markdown', 'setlocal wrap'},
            {'FileType', 'markdown', 'setlocal spell'}
        },
        _packer_compile = {
            {'BufWritePost', 'plugins.lua', 'PackerCompile'}
        },
        _term = {
            {'TermOpen', 'term://*', 'lua set_terminal_keymaps()'}
        },
        _opti = {
            {'BufReadPost', '*', 'if getfsize(expand("%")) > 500000 | silent! execute "TSBufDisable highlight" | endif'},
            {'BufReadPost', '*', 'if getfsize(expand("%")) > 1000000 | syntax clear | endif'}
        },
        _lualine = {
            {'ColorScheme', '*', 'lua require("plugins.lualine")'},
            {'ColorScheme', '*', 'lua require("colors").config()'}
        },
        _coc = {
            {'FileType', '*', 'let b:coc_suggest_disable = 1'},
            {'User', 'CocExplorerOpenPre', 'let g:explorer_is_open = 1'},
            {'User', 'CocExplorerQuitPre', 'let g:explorer_is_open = 0'},
            {'VimEnter', '*', 'let g:explorer_is_open = 0'}

        },
        _cmp = {
            {'FileType', 'gitcommit', 'lua require("cmp").setup.buffer { enable = false }'}
        }
    }

end

return M
