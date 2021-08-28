local autocmds = {
    _general = {
        { "BufRead", "*", [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]] },
        { "BufEnter", "*", "silent! lcd %:p:h" },
        { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    },
    _git = {
        { "FileType", "gitcommit", "setlocal wrap" },
        { "FileType", "gitcommit", "setlocal spell" },
    },
    _markdown = {
        { "FileType", "markdown", "setlocal wrap" },
        { "FileType", "markdown", "setlocal spell" },
    },
    _auto_resize = {
        { "VimResized", "*", "wincmd =" },
    },
    _packer_compile = {
        { "BufWritePost", "plugins.lua", "PackerCompile" },
    },
    _term = {
        { "TermOpen", "term://*", "lua set_terminal_keymaps()"}
    }
}

for gp, definition in pairs(autocmds) do
    vim.cmd("augroup " .. gp)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
        local cmd = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
        vim.cmd(cmd)
    end

    vim.cmd "augroup END"
end
