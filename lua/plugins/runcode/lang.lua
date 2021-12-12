local curr = vim.bo.filetype

return {
    lang = {
        typescript = 'ts-node #',
        javascript = 'node #',
        c = 'gcc # -o @.exe;.\\@.exe',
        go = 'go run #',
        java = 'javac #;java @',
        cpp = 'g++ -o @.exe #;start @.exe',
        ps1 = 'powershell ./#',
    },
    intro = {
        php = '<?php'
    },
    sub = {
        normal = {
            ['#'] = '%:t',
            ['@'] = '%:t:r'
        },
        visual = {
            ['#'] = string.format('%s\\runcode_log\\%s.%s',vim.fn.stdpath('data'),curr,curr),
            ['@'] = string.format('%s\\runcode_log\\%s',vim.fn.stdpath('data'),curr)
        }
    }
}
