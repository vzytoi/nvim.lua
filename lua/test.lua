vim.cmd [[

function! Test(...)

    execute('e ~/appdata/local/nvim/test/main.' . a:1)

endfunction

command! -nargs=1 Test call Test(<f-args>)

]]
