vim.cmd [[
    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-j>', '<C-n>']
    let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-k>', '<C-p>']
    let g:ycm_key_list_stop_completion = ['<C-y>', '<Cr>']
]]

vim.cmd("let g:ycm_filetype_blacklist = { 'tagbar' : 1, 'qf' : 1, 'notes' : 1, 'markdown' : 1, 'unite' : 1, 'text' : 1, 'vimwiki' : 1, 'pandoc' : 1, 'infolog' : 1, 'mail' : 1, 'TelescopePrompt': 1 }")
