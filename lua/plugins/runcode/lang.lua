local curr = vim.bo.filetype

return {
    lang = {
        typescript = 'ts-node #',
        javascript = 'node #',
        c = 'gcc # -o @.exe;./@.exe',
        go = 'go run #',
        java = 'javac #',
        cpp = 'g++ -o @.exe #;./@.exe',
        ps1 = 'powershell ./#'
    },
    intro = {
        php = '<?php\n',
        python = 'from math import *\n'
    },
    sub = {
        normal = {
            ['#'] = '%:t',
            ['@'] = '%r'
        },
        visual = {
            ['#'] = vim.fn.stdpath('data')..'\\runcode_log\\' .. curr .. '.' .. curr,
            ['@'] = string.format(
                    vim.fn.stdpath('data')..'\\runcode_log\\%s',
                    curr
                ),
        }
    }
}
