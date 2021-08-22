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
        keys = { 'S', 's' }
    }

    use {
        'ryanoasis/vim-devicons',
        event = 'VimEnter'
    }

    use {
        'LionC/nest.nvim',
        config = function()
            require 'plugins.mappings'
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        disable = true,
        config = function()
            require 'plugins.treesitter'
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
        config = function()
            require('trim').setup({
                disable = {"json", "javascript", "css"}
            })
        end
    }

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'codedark'
                }
            }
        end
    }

    use {
        'nvim-treesitter/playground',
        disable = true
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        },
        -- cmd = 'Telescope',
        config = function()
            require 'plugins.telescope'
        end
    }

    use {
        'tpope/vim-commentary',
        event = 'BufRead'
    }

    use {
        'wellle/targets.vim',
        event = 'BufRead'
    }

    use {
        'tpope/vim-surround',
        event = 'BufRead'
    }

    use {
        'Jorengarenar/vim-MvVis',
        event = 'CursorMoved'
    }

    use {
        'romainl/vim-cool',
        event = 'VimEnter'
    }

    use {
        'codota/tabnine-vim',
        event = 'VimEnter',
        config = function()
            require 'plugins.tabnine'
        end
    }

end)
