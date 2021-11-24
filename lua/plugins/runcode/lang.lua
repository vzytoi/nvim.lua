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
