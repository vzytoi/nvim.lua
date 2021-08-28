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
        'tpope/vim-fugitive',
        cmd = 'G'
    }

    use {
        -- 100%.lua
        'LionC/nest.nvim',
        config = function()
            require 'mappings'
        end
    }

    use {
        -- 41.2%.lua / 1.8%.vim
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
                check_ts = true,
                enable_check_bracket_line = true
            })
        end,
        after = 'nvim-treesitter'
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    use {
        'nvim-treesitter/playground',
        after = 'nvim-treesitter'
    }

    use {
        'RRethy/nvim-treesitter-textsubjects',
        after = 'nvim-treesitter'
    }

    use {
        'tpope/vim-commentary'
    }

    use {
        -- 99.8%.lua
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
        end
    }

    use {
        'cappyzawa/trim.nvim',
        event = 'BufWritePre',
        config = function()
            require('trim').setup({
                disable = {"json", "javascript", "css"},
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
        requires = {
            { 'nvim-lua/plenary.nvim' }
        },
        config = require('plugins.telescope').config
    }

    use {
        -- 7.2%.lua
        'codota/tabnine-vim',
        event = 'InsertEnter',
        config = function()
            require('plugins.tabnine')
        end
    }

    use {
        'ryanoasis/vim-devicons',
        event = 'VimEnter'
    }

    use {
        -- 98.1%.lua
        'wellle/targets.vim',
        event = 'BufRead'
    }

    use {
        'tpope/vim-surround',
        event = 'BufRead'
    }

    use {
        'Jorengarenar/vim-MvVis',
        event = 'BufRead'
    }

    use {
        'romainl/vim-cool',
        event = 'VimEnter'
    }

    use {
        'mhartington/formatter.nvim',
        config = require('plugins.formatter').config()
    }

end)
