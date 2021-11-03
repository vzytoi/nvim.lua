local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'
    use 'Jorengarenar/vim-MvVis'
    use 'tpope/vim-surround'
    use 'romainl/vim-cool'
    use 'kyazdani42/nvim-web-devicons'
    use 'wellle/targets.vim'
    use 'SirVer/ultisnips'

    use {
        'jaredgorski/spacecamp',
        event = 'BufReadPost'
    }

    use {
        'justinmk/vim-sneak',
        keys = {
            {'n', 'S' }, {'n', 's'}
        }
    }

    use {
        'LionC/nest.nvim',
        config = function()
            require('mappings')
        end
    }

    use {
        'cappyzawa/trim.nvim',
        event = 'BufWritePre',
        config = function()
            require('trim').setup({
                disable = {"json", "javascript", "css"},
            })
        end
    }

    use {
        'akinsho/toggleterm.nvim',
        cmd = "ToggleTerm",
        config = function()
            require 'plugins.term'.config()
        end
    }

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require 'plugins.lualine'.config()
        end
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
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('plugins.telescope').config()
        end
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
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
        'code-biscuits/nvim-biscuits',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-biscuits').setup({
                cursor_line_only = true,
                default_config = {
                    prefix_string = ""
                }
            })
        end
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
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            require 'plugins.coc'
        end,
        event = 'VimEnter'
    }

end)
