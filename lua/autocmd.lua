vim.cmd([[
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" | execute("normal `\"") | endif
    autocmd FileType * set fo-=c fo-=r fo-=o fo+=j
    autocmd! BufWritePost plugins.lua source $MYVIMRC | PackerCompile
    autocmd! TermOpen term://* lua set_terminal_keymaps()
    autocmd BufEnter * silent! lcd %:p:h
]])
