local M = {}

local function copy(table)

    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret

end

local function mergeTables(a, b)

    local ret = copy(a)

    for k, v in pairs(b) do
        ret[k] = v
    end

    return ret

end

function M.RunCodeBuffer()

    vim.bo.bufhidden = 'delete'
    vim.bo.buftype = 'nofile'
    vim.bo.swapfile = false
    vim.bo.buflisted = false
    vim.wo.winfixheight = true
    vim.wo.number = false
    vim.wo.relativenumber = false

end

function M.disablePlugins()

    local plug_buitlins = {
        'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugins',
        'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
        'matchit', 'matchparen', 'logiPat', 'rrhelper',
        'remote_plugins', 'man', 'shada_plugin', 'spellfile_plugin', 'tutor_mode_plugin'
    }

    if vim.fn.isdirectory(vim.fn.argv()[1]) == 0 then
        plug_buitlins = mergeTables(
            plug_buitlins,
            {'netrw', 'netrwPlugin', 'netrwSettings'}
        )
    end

    for _, p in pairs(plug_buitlins) do
        vim.g["loaded_" .. p] = 1
    end
end

M.disablePlugins()

function M.loadOptions()

    local options = {
        rnu = true,
        nu = true,
        showcmd = false,
        ruler = false,
        lazyredraw = true,
        synmaxcol = 2048,
        completeopt = {"menuone", "noselect"},
        expandtab = true,
        autoindent = true,
        smartindent = true,
        cindent = true,
        shiftwidth = 4,
        softtabstop = 4,
        tabstop = 8,
        wrap = false,
        ignorecase = true,
        smartcase = true,
        mouse = 'a',
        splitright = true,
        splitbelow = true,
        timeout = true,
        timeoutlen = 200,
        ttimeout = true,
        ttimeoutlen = 10,
        updatetime = 500,
        redrawtime = 1500,
        scrolloff = 8,
        undofile = true,
        undolevels = 10000,
        writebackup = false,
        swapfile = false,
    }

    for k, v in pairs(options) do
        vim.opt[k] = v
    end

    vim.opt.formatoptions = vim.opt.formatoptions
                        - 'a'
                        - 't'
                        + 'c'
                        + 'q'
                        - 'o'
                        + 'r'
                        + 'n'
                        + 'j'
                        - '2'

    vim.cmd [[set shortmess+=c]]

end

function M.ColorOpt()

    vim.o.termguicolors = true
    vim.o.background = 'dark'

    vim.cmd('colorscheme spacecamp')

end

function M.config()

    M.disablePlugins()
    M.loadOptions()
    M.ColorOpt()

    vim.g['loaded_python_provider'] = false
    vim.g['python3_host_prog'] = '~/AppData/Local/Programs/Python/Python39/python.exe'

    vim.g['UltiSnipsExpandTrigger'] = '<c-s>'
    vim.g['UltiSnipsJumpForwardTrigger'] = '<tab>'
    vim.g['UltiSnipsJumpBackwardTrigger'] = '<s-tab>'
    vim.g['UltiSnipsSnippetDirectories'] = { '~/appdata/local/nvim/snips' }

    vim.g['sneak#use_ic_scs'] = true

    vim.cmd [[
    let &shell = has('win32') ? 'powershell' : 'pwsh'
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote = shellxquote=
    ]]

end

return M
