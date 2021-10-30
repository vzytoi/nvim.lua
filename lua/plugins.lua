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
        'SirVer/ultisnips',
        event = 'BufReadPost'
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
            require 'plugins.lualine'.config()
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
        'akinsho/toggleterm.nvim',
        cmd = "ToggleTerm",
        config = function()
            require 'plugins.term'.config()
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = require('plugins.telescope').config
    }

    use {
        'kyazdani42/nvim-web-devicons',
        event = 'VimEnter'
    }

    use {
        'jaredgorski/spacecamp',
        event = 'BufReadPost'
    }

    use {
	'cormacrelf/vim-colors-github',
	event = 'BufReadPost'
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
        event = 'BufReadPost'
    }

    use {
        'romainl/vim-cool',
        event = 'VimEnter'
    }

end)
