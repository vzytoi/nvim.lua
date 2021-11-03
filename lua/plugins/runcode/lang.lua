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
        ['#'] = '%:t',
        ['@'] = '%:r'
    }
}

-- TODO: finir la liste (30/10/2021 02:11:36)