local set = vim.opt

set.rnu = true
set.nu = true

set.softtabstop = 4
set.tabstop = 4
set.expandtab = true
set.smarttab = true
set.smartindent = true
set.shiftwidth = 4

local plug_buitlins = {
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip",
    "zip", "zipPlugin", "tar", "tarPlugin", "getscript",
    "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin",
    "logipat", "rrhelper", "spellfile_plugin", "matchit",
    "matchparen",
}

for _, p in pairs(plug_buitlins) do
    vim.g["loaded_" .. p] = 1
end

vim.cmd [[ colorscheme spacecamp ]]

set.termguicolors = true
set.background = 'dark'

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

vim.cmd [[ let g:loaded_python_provider = 0 ]]

set.formatoptions = set.formatoptions
  - "a"
  - "t"
  + "c"
  + "q"
  - "o"
  + "r"
  + "n"
  + "j"
  - "2"
