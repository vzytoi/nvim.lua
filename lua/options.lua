local plug_buitlins = {
    'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugins',
    'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
    'matchit', 'matchiparen', 'logiPat', 'rrhelper',
    'netrw', 'netrwPlugin', 'netrwSettings', 'remote_plugins', 'man',
    'shada_plugin', 'spellfile_plugin', 'tutor_mode_plugin'
}

for _, p in pairs(plug_buitlins) do
    vim.g["loaded_" .. p] = 1
end

function HI()

    vim.o.termguicolors = true
    vim.o.background = 'dark'

    vim.cmd('colorscheme spacecamp')

    local hi = {
        ["Normal"] = {
            guifg = "#EEEEEE", guibg = "#080808", gui = "none" },
        ["NonText"] = {
            guifg = '#6B6B6B', guibg = 'none', gui = 'none' },
        ["SignColumn"] = {
            guifg = 'none', guibg = 'none', gui = 'none', },
        ["LineNr"] = {
            guifg = '#6B6B6B', guibg='none', gui='none' },
        ["MatchParen"] = {
            guifg = '#F0D50C', guibg='none', gui='none' },
        ["VertSplit"] = {
            guifg = '#6B6B6B', guibg='none', gui='none' },
        ["CocUnusedHighlight"] = {
            guibg = 'none', guifg='none', gui='underline' },
        ["CocHintHighlight"] = {
            cterm = 'undercurl', guisp='#000000', }
    }

    for m, t in pairs(hi) do
        vim.cmd('hi clear ' .. m)
        local s = 'hi ' .. m
        for k, v in pairs(t) do
            s = s .. ' ' .. table.concat({k,v}, '=')
        end
        vim.cmd(s)
    end

end

HI()

local set = vim.opt

set.rnu = true
set.nu = true

set.showcmd = false
set.ruler = false

set.softtabstop = 4
set.tabstop = 4
set.expandtab = true
set.smarttab = true
set.smartindent = true
set.shiftwidth = 4

set.wrap = false

set.ignorecase = true
set.smartcase = true

set.mouse = 'a'

set.splitright = true
set.splitbelow = true

set.timeout = true
set.timeoutlen = 200
set.ttimeout = true
set.ttimeoutlen = 10
set.updatetime = 500
set.redrawtime = 1500

set.lazyredraw = true

set.scrolloff = 8

set.undofile = true

vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

vim.cmd [[
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-j>', '<C-n>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-k>', '<C-p>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<Cr>']
]]

vim.cmd [[
let g:loaded_python_provider = 0
let g:python3_host_prog = '~\AppData\Local\Programs\Python\Python39\python.exe'
]]
