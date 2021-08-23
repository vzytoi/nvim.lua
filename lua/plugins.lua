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
        -- 0%.lua
        'justinmk/vim-sneak',
        opt = true,
        keys = { 'S', 's' }
    }

    use {
        -- 100%.lua
        'LionC/nest.nvim',
        config = function()
            require 'plugins.mappings'
        end
    }

    use {
        -- 41.2%.lua / 1.8%.vim
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        disable = true,
        config = function()
            require 'plugins.treesitter'
        end
    }

    use {
        -- 99.8%.lua
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require 'plugins.ll'.config()
        end
    }

    use {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            require 'plugins.coc'
        end
    }

    use {
        -- 100%.lua
        'cappyzawa/trim.nvim',
        event = 'BufWritePre',
        config = function()
            require('trim').setup({
                disable = {"json", "javascript", "css"}
            })
        end
    }

    use {
        -- 99.3%.lua
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugins.gitsigns').config()
        end
    }

    use {
        -- 98%.lua
        'akinsho/toggleterm.nvim',
        config = function()
            require 'plugins.term'.config()
        end
    }

    use {
        -- 99.1%.lua
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        },
        config = require('plugins.telescope').config
    }

    use {
        -- 7.2%.lua
        'codota/tabnine-vim',
        event = 'VimEnter',
        config = function()
            require('plugins.tabnine')
        end
    }

    use {
        'nvim-treesitter/playground',
        disable = true
    }

    use {
        'ryanoasis/vim-devicons',
        event = 'VimEnter'
    }

    use {
        'tpope/vim-commentary',
        event = 'VimEnter'
    }

    use {
        -- 98.1%.lua
        'wellle/targets.vim',
        event = 'VimEnter'
    }

    use {
        'tpope/vim-surround',
        event = 'VimEnter'
    }

    use {
        'Jorengarenar/vim-MvVis',
        event = 'VimEnter'
    }

    use {
        'romainl/vim-cool',
        event = 'VimEnter'
    }

end)
