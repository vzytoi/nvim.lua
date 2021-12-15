return {
    formats = {
        lua = {
            cmd = 'stylua #',
            opts = {
                '--quote-style AutoPreferSingle',
                '--indent-type Spaces',
                '--indent-width 4',
                '--column-width 70',
                ['visual'] = {
                    '--range-start ',
                    '--range-end '
                }
            }
        }
    },
    sub = {
        ['#'] = '%:t',
    }
}
