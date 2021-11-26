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
            _ = {
                {
                    cterm = 'bold',
                    ctermfg = '10',
                    ctermbg = '17',
                    guifg = 'bg',
                },
                {
                    DiffAdd = {guibg = 'darkGreen'},
                    DiffDelete = {guibg = 'darkRed'},
                    DiffChange = {guibg = 'darkOrange'},
                    DiffText = {guibg = 'darkBlue'},
                }
            }
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
