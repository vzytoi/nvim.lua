local M = {}

function M.setup()

    return {
        all = {
            Normal = {guifg = '#EEEEEE', guibg = '#080808'},
            NonText = {guifg = '#6B6B6B'},
            SignColumn = {},
            LineNr = {guifg = '#6B6B6B'},
            BiscuitColor = {guifg = '#383838'},
            VertSplit = {guifg = '#6B6B6B'};
            DiffAdd = {cterm='bold', ctermfg='10', ctermbg='17', guifg='bg', guibg='darkGreen'},
            DiffDelete = {cterm='bold', ctermfg='10', ctermbg='17', guifg='bg', guibg='darkRed'},
            DiffChange = {cterm='bold', ctermfg='10', ctermbg='17', guifg='bg', guibg='darkOrange'},
            DiffText = {cterm='bold', ctermfg='10', ctermbg='88', guifg='bg', guibg='darkBlue'}
        },
        spacecamp = {
            MatchParen = {guifg = '#F0D50C'},
            Todo = {guifg = '#CF73E6'},
            CocUnusedHighlight = {gui = 'underline'},
            CocHintHighlight = {cterm = 'undercurl', guisp ='#000000'},
        }
    }

end

return M
