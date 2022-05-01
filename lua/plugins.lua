M = {}

function M.config()

    local utils = require('utils')
    local execute = vim.api.nvim_command
    local fn = vim.fn

    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
        execute 'packadd packer.nvim'
    end

    return require('packer').startup{function(use)

        use 'wbthomason/packer.nvim'
        use 'nvim-lua/plenary.nvim'

        use 'Jorengarenar/vim-MvVis'
        use 'tpope/vim-surround'
        use 'romainl/vim-cool'
        use 'kyazdani42/nvim-web-devicons'
        use 'wellle/targets.vim'
        -- use 'SirVer/ultisnips'
        use 'tpope/vim-sleuth'
        use 'bogado/file-line'
        use 'farmergreg/vim-lastplace'
        use 'michaeljsmith/vim-indent-object'
        use 'KabbAmine/vCoolor.vim'

        use 'morhetz/gruvbox'
        use 'google/vim-colorscheme-primary'
        use 'arzg/vim-colors-xcode'

        use {
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup { }
            end
        }

        use {
            'rktjmp/paperplanes.nvim',
            config = function()
                require('paperplanes').setup {
                    register = "*",
                    provider = "ix.io"
                }
            end
        }

        use {
            'xiyaowong/accelerated-jk.nvim',
            config = [[require('accelerated-jk').setup()]]
        }

        use {
            "max397574/better-escape.nvim",
            config = function()
                require("better_escape").setup {
                    mapping = {"kj", "jk"}
                }
            end
        }

        use {
            'sindrets/diffview.nvim',
            config = function()
                require('diffview').setup {
                    file_panel = {
                        position = 'bottom'
                    }
                }
            end
        }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup {
                    pre_hook = function(ctx)
                        local U = require 'Comment.utils'

                        local location = nil
                        if ctx.ctype == U.ctype.block then
                            location = require('ts_context_commentstring.utils').get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                            location = require('ts_context_commentstring.utils').get_visual_start_location()
                        end

                        return require('ts_context_commentstring.internal').calculate_commentstring {
                            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
                            location = location,
                        }
                    end
                }
            end,
            requires = {
                {
                    'JoosepAlviste/nvim-ts-context-commentstring',
                    after = 'nvim-treesitter'
                }
            }
        }

        use {
            'mbbill/undotree',
            cmd = {
                'UndotreeShow',
                'UndotreeToggle',
                'UndotreeFocus',
                'UndotreeHide'
            }
        }

        use {
            'folke/persistence.nvim',
            event = 'BufReadPre',
            config = [[require('persistence').setup()]]
        }

        use {
            'voldikss/vim-browser-search',
            cmd = 'BrowserSearch',
            requires = { 'RishabhRD/popfix' }
        }

        use {
            'dstein64/vim-startuptime',
            cmd = 'StartupTime'
        }

        use {
            'hrsh7th/nvim-cmp',
            config = [[require('plugins.cmp').config()]],
            requires = {
                'onsails/lspkind-nvim',
                -- {
                --     'quangnguyen30192/cmp-nvim-ultisnips',
                --     config = function()
                --         require('cmp_nvim_ultisnips').setup{}
                --     end
                -- },

                'hrsh7th/cmp-path',
                'hrsh7th/cmp-calc',
                {
                    'tzachar/cmp-tabnine',
                    run = function()
                        if utils.is_win() then
                            return 'powershell ./install.ps1'
                        else
                            return './install.sh'
                        end
                    end
                }
            }
        }

        use {
            'windwp/nvim-autopairs',
            config = [[require('nvim-autopairs').setup{}]]
        }

        use {
            'jaredgorski/spacecamp',
            event =  'GUIEnter'
        }

        use {
            'justinmk/vim-sneak',
            keys = {
                {'n', 'S' }, {'n', 's'}
            }
        }

        use {
            'LionC/nest.nvim',
            config = [[require('mappings')]]
        }

        use {
            'cappyzawa/trim.nvim',
            event = 'BufWritePre',
            config = [[require('trim').setup({})]]
        }

        use {
            'akinsho/toggleterm.nvim',
            cmd = { 'ToggleTerm', 'TermExec' },
            config = [[require('plugins.term').config()]]
        }

        use {
            'hoob3rt/lualine.nvim',
            config = [[require('plugins.lualine').config()]]
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
            config = [[require('plugins.telescope').config()]]
        }

        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make'
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            event = 'BufRead',
            run = ':TSUpdate',
            config = [[require('plugins.treesitter')]]
        }

        use {
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
        }

        use {
            'RRethy/nvim-treesitter-textsubjects',
            after = 'nvim-treesitter',
        }

        use {
            'nvim-treesitter/nvim-tree-docs',
            after = 'nvim-treesitter'
        }

        use {
            'code-biscuits/nvim-biscuits',
            after = 'nvim-treesitter',
            config = function()
                require('nvim-biscuits').setup({
                    cursor_line_only = true,
                    default_config = {
                        prefix_string = ''
                    }
                })
            end
        }

        use {
            'neoclide/coc.nvim',
            branch = 'release',
            config = [[require('plugins.coc')]]
        }

        use {
            'alvan/vim-closetag',
            ft = { 'html', 'php' },
            event = 'BufWritePre'
        }

        end
    }

end

return M
