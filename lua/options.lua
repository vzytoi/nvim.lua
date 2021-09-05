vim.cmd [[
    let g:loaded_python_provider = 0
    let g:python3_host_prog = '~\AppData\Local\Programs\Python\Python39\python.exe'
]]

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

vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

local set = vim.opt

set.rnu = true
set.nu = true

set.softtabstop = 4
set.tabstop = 4
set.expandtab = true
set.smarttab = true
set.smartindent = true
set.shiftwidth = 4

vim.cmd [[ colorscheme spacecamp ]]

vim.o.termguicolors = true
vim.o.background = 'dark'

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

vim.cmd('hi Normal guifg=#EEEEEE guibg=#0a0a0a gui=none')
vim.cmd('hi NonText guifg=#6B6B6B guibg=none gui=none')
vim.cmd('hi SignColumn guifg=none guibg=none gui=none')
vim.cmd('hi LineNr guifg=#6B6B6B guibg=none gui=none')
vim.cmd('hi MatchParen guifg=#F0D50C guibg=none gui=none')
vim.cmd('hi CocUnusedHighlight guibg=none guifg=none gui=underline')
vim.cmd('hi CocHintHighlight cterm=undercurl guisp=#000000')
vim.cmd('hi CocHintHighlight cterm=undercurl guisp=#000000')

vim.cmd [[
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-j>', '<C-n>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-k>', '<C-p>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<Cr>']
]]
