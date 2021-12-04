return {
    lang = {
        typescript = 'ts-node #',
        javascript = 'node #',
        c = 'gcc # -o @.exe;./@.exe',
        go = 'go run #',
        java = 'javac #',
        cpp = 'g++ -o @.exe #;./@.exe'
    },
    sub = {
        normal = {
            ['#'] = '%:t',
            ['@'] = '%r'
        },
        visual = {
            ['#'] = string.format(
                    "C:\\Users\\Cyprien\\appdata\\local\\nvim\\lua\\plugins\\runcode\\log\\%s.%s",
                    vim.bo.filetype, vim.bo.filetype),
            ['@'] = string.format("C:\\Users\\Cyprien\\appdata\\local\\nvim\\lua\\plugins\\runcode\\log\\%s",
                    vim.bo.filetype)
        }
    }
}
