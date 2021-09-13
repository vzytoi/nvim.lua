local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)

    use { 'wbthomason/packer.nvim' }

    use {
        'justinmk/vim-sneak',
        opt = true,
        keys = { {'n', 'S' }, {'n', 's'} }
    }

    use {
        'RishabhRD/nvim-cheat.sh',
        requires = { 'RishabhRD/popfix' },
        cmd = { 'Cheat' }
    }

    use {
        'tpope/vim-fugitive',
        cmd = { 'G', 'Gdiff' }
    }

    use {
        'LionC/nest.nvim',
        config = function()
            require 'mappings'
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        run = ':TSUpdate',
        config = function()
            require 'plugins.treesitter'
        end,
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                active = true,
                check_ts = true
            })
        end,
        after = 'nvim-treesitter'
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    use {
        'RRethy/nvim-treesitter-textsubjects',
        after = 'nvim-treesitter'
    }

    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter'
    }

    use {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup({
                comment_empty = false,
                hook = function()
                    require('ts_context_commentstring.internal').update_commentstring()
                end
            })
        end,
        after = 'nvim-ts-context-commentstring'
    }

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require 'plugins.ll'.config()
        end
    }

    use {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            require 'plugins.coc'
        end,
        event = 'VimEnter'
    }

    use {
        'cappyzawa/trim.nvim',
        event = 'BufWritePre',
        config = function()
            require('trim').setup({
                disable = {"text", "json", "javascript", "css"},
                patterns = {
                    [[%s/\s\+$//e]],
                    [[%s/\($\n\s*\)\+\%$//]],
                    [[%s/\%^\n\+//]],
                    [[%s/\(\n\n\)\n\+/\1/]],
                }
            })
        end
    }

    use {
        -- 99.3%.lua
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        cond = function()
            return vim.fn.isdirectory ".git" == 1
        end,
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugins.gitsigns').config()
        end
    }

    use {
        -- 98%.lua
        'akinsho/toggleterm.nvim',
        cmd = "ToggleTerm",
        config = function()
            require 'plugins.term'.config()
        end
    }

    use {
        -- 99.1%.lua
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        requires = { 'nvim-lua/plenary.nvim' },
        config = require('plugins.telescope').config
    }

    use {
        'kyazdani42/nvim-web-devicons',
        event = 'VimEnter'
    }

    use {
        'vzytoi/spacecamp',
        event = 'BufReadPost'
    }

    use {
        'glepnir/zephyr-nvim',
        config = function()
            require'zephyr'
        end
    }

    use {
        'wellle/targets.vim',
        event = 'BufReadPost'
    }

    use {
        'tpope/vim-surround',
        event = 'BufReadPost'
    }

    use {
        'Jorengarenar/vim-MvVis',
        event = 'VimEnter'
    }

    use {
        'romainl/vim-cool',
        event = 'VimEnter'
    }

    use {
        'EvanQuan/vim-executioner',
        cmd = 'Executioner'
    }

end)
