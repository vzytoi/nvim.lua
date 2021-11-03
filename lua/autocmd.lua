local autocmds = {
    _general = {
        {"BufRead", "*", [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]]},
        {"BufEnter", "*", "silent! lcd %:p:h"},
        {"BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"},
        {"BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"},
        {"VimResized", "*", "wincmd ="}
    },
    _markdown = {
        {"FileType", "markdown", "setlocal wrap"},
        {"FileType", "markdown", "setlocal spell"}
    },
    _packer_compile = {
        {"BufWritePost", "plugins.lua", "PackerCompile"}
    },
    _term = {
        {"TermOpen", "term://*", "lua set_terminal_keymaps()"}
    },
    _opti = {
        {"BufReadPost", "*", "if getfsize(expand('%')) > 500000 | silent! execute 'TSBufDisable highlight' | endif"},
        {"BufReadPost", "*", "if getfsize(expand('%')) > 1000000 | syntax clear | endif"}
    },
    _lualine = {
        {"ColorScheme", "*", "lua require('plugins.lualine')"}
    }
}

for gp, defi in pairs(autocmds) do
    vim.cmd("augroup " .. gp)
    vim.cmd("autocmd!")

    for _, def in pairs(defi) do
        vim.cmd(
            table.concat(
                vim.tbl_flatten{"autocmd", def}, " "
            )
        )
    end

    vim.cmd("augroup END")
end
