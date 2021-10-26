local plug_buitlins = {
    'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugins',
    'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
    'matchit', 'matchparen', 'logiPat', 'rrhelper',
    'netrw', 'netrwPlugin', 'netrwSettings', 'remote_plugins', 'man',
    'shada_plugin', 'spellfile_plugin', 'tutor_mode_plugin'
}

for _, p in pairs(plug_buitlins) do
    vim.g["loaded_" .. p] = 1
end

local set = vim.opt

set.rnu = true
set.nu = true

set.showcmd = false
set.ruler = false
set.lazyredraw = true
set.synmaxcol = 2048

set.completeopt={"menuone", "noselect", "preview"}

set.expandtab = true
set.autoindent = true
set.smartindent = true
set.cindent = true

set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 8

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

vim.cmd [[
let &shell = has('win32') ? 'powershell' : 'pwsh'
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
set shellquote= shellxquote=
]]
