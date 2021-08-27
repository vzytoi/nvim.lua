vim.cmd('autocmd! BufWritePost plugins.lua source $MYVIMRC | PackerCompile')
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd[[au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" | execute("normal `\"") | endif]]
