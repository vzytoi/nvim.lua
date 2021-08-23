vim.cmd [[
    autocmd BufWritePost plugins.lua source $MYVIMRC | PackerCompile
    autocmd! TermOpen term://* lua set_terminal_keymaps()
]]
