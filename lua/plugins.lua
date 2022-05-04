M = {}

function M.config()
    local utils = require("utils")
    local execute = vim.api.nvim_command
    local fn = vim.fn

    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
        execute "packadd packer.nvim"
    end

    return require("packer").startup {
        function(use)
            use "wbthomason/packer.nvim"
            use "nvim-lua/plenary.nvim"

            use "Jorengarenar/vim-MvVis"
            use "tpope/vim-surround"
            use "romainl/vim-cool"
            use "wellle/targets.vim"
            use "tpope/vim-sleuth"
            use "bogado/file-line"
            use "farmergreg/vim-lastplace"
            use "michaeljsmith/vim-indent-object"
            use "KabbAmine/vCoolor.vim"
            use "morhetz/gruvbox"
            use "johngrib/vim-game-snake"
            use "lewis6991/github_dark.nvim"
            use "ygm2/rooter.nvim"

            use {
                "mhartington/formatter.nvim",
                config = function()
                    require("plugins.formatter").config()
                end
            }

            use {
                "williamboman/nvim-lsp-installer",
                {
                    "neovim/nvim-lspconfig",
                    config = function()
                        require("nvim-lsp-installer").setup {}
                        require("plugins.lsp").config()
                    end
                }
            }

            use {
                "kyazdani42/nvim-tree.lua",
                requires = {
                    "kyazdani42/nvim-web-devicons"
                },
                config = function()
                    require("plugins.tree").config()
                end
            }

            use {
                "kkoomen/vim-doge",
                run = function()
                    vim.fn["doge#install"]()
                end
            }

            use {
                "folke/zen-mode.nvim",
                config = function()
                    require("zen-mode").setup {}
                end
            }

            use {
                "rktjmp/paperplanes.nvim",
                config = function()
                    require("paperplanes").setup {
                        register = "*",
                        provider = "ix.io"
                    }
                end
            }

            use {
                "xiyaowong/accelerated-jk.nvim",
                config = [[require('accelerated-jk').setup()]]
            }

            use {
                "sindrets/diffview.nvim",
                config = function()
                    require("diffview").setup {
                        file_panel = {
                            position = "bottom"
                        }
                    }
                end
            }

            use {
                "numToStr/Comment.nvim",
                config = function()
                    require("Comment").setup {
                        pre_hook = function(ctx)
                            local U = require "Comment.utils"

                            local location = nil
                            if ctx.ctype == U.ctype.block then
                                location = require("ts_context_commentstring.utils").get_cursor_location()
                            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                                location = require("ts_context_commentstring.utils").get_visual_start_location()
                            end

                            return require("ts_context_commentstring.internal").calculate_commentstring {
                                key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
                                location = location
                            }
                        end
                    }
                end,
                requires = {
                    {
                        "JoosepAlviste/nvim-ts-context-commentstring",
                        after = "nvim-treesitter"
                    }
                }
            }

            use {
                "folke/persistence.nvim",
                event = "BufReadPre",
                config = [[require('persistence').setup()]]
            }

            use {
                "dstein64/vim-startuptime",
                cmd = "StartupTime"
            }

            use {
                "hrsh7th/nvim-cmp",
                config = [[require('plugins.cmp').config()]],
                requires = {
                    "onsails/lspkind-nvim",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-calc",
                    {
                        "tzachar/cmp-tabnine",
                        run = function()
                            if utils.is_win() then
                                return "powershell ./install.ps1"
                            else
                                return "./install.sh"
                            end
                        end
                    },
                    "hrsh7th/cmp-nvim-lsp"
                }
            }

            use {
                "windwp/nvim-autopairs",
                config = [[require('nvim-autopairs').setup{}]]
            }

            use {
                "jaredgorski/spacecamp",
                event = "GUIEnter"
            }

            use {
                "justinmk/vim-sneak",
                keys = {
                    {"n", "S"},
                    {"n", "s"}
                }
            }

            use {
                "LionC/nest.nvim",
                config = [[require('mappings')]]
            }

            use {
                "cappyzawa/trim.nvim",
                event = "BufWritePre",
                config = [[require('trim').setup({})]]
            }

            use {
                "akinsho/toggleterm.nvim",
                cmd = {"ToggleTerm", "TermExec"},
                config = [[require('plugins.term').config()]]
            }

            use {
                "hoob3rt/lualine.nvim",
                config = [[require('plugins.lualine').config()]]
            }

            use {
                "RishabhRD/nvim-cheat.sh",
                requires = {"RishabhRD/popfix"},
                cmd = {"Cheat"}
            }

            use {
                "tpope/vim-fugitive",
                cmd = {"G", "Gdiff"}
            }

            use {
                "nvim-telescope/telescope.nvim",
                config = [[require('plugins.telescope').config()]]
            }

            use {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make"
            }

            use {
                "nvim-treesitter/nvim-treesitter",
                event = "BufRead",
                run = ":TSUpdate",
                config = [[require('plugins.treesitter')]]
            }

            use {
                "nvim-treesitter/nvim-treesitter-textobjects",
                after = "nvim-treesitter"
            }

            use {
                "RRethy/nvim-treesitter-textsubjects",
                after = "nvim-treesitter"
            }

            use {
                "code-biscuits/nvim-biscuits",
                after = "nvim-treesitter",
                config = function()
                    require("nvim-biscuits").setup(
                        {
                            cursor_line_only = true,
                            default_config = {
                                prefix_string = ""
                            }
                        }
                    )
                end
            }

            use {
                "alvan/vim-closetag",
                ft = {"html", "php"},
                event = "BufWritePre"
            }
        end
    }
end

return M
