vim.cmd [[
autocmd! BufWritePost plugins.lua source $MYVIMRC | PackerCompile
autocmd! TermOpen term://* lua set_terminal_keymaps()
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" | execute("normal `\"") | endif
]]
