local M = {}

function M.config()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.api.nvim_command("packadd packer.nvim")
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
            use "morhetz/gruvbox"
            use "github/copilot.vim"

            use {
                "ThePrimeagen/refactoring.nvim",
                config = function()
                    require("refactoring").setup({})
                end,
                after = {
                    "nvim-treesitter"
                }
            }

            use {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip.loaders.from_snipmate").lazy_load()
                end
            }

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
                cmd = "DogeGenerate",
                run = function()
                    vim.fn["doge#install"]()
                end
            }

            use {
                "folke/zen-mode.nvim",
                cmd = "ZenMode",
                config = function()
                    require("zen-mode").setup()
                end
            }

            use {
                "rktjmp/paperplanes.nvim",
                cmd = "PP",
                config = function()
                    require("paperplanes").setup({
                        provider = "paste.rs",
                    })
                end
            }

            use {
                "xiyaowong/accelerated-jk.nvim",
                config = function()
                    require("accelerated-jk").setup()
                end
            }

            use {
                "sindrets/diffview.nvim",
                cmd = "DiffviewOpen",
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
                config = function()
                    require("persistence").setup()
                end
            }

            use {
                "dstein64/vim-startuptime",
                cmd = "StartupTime"
            }

            use {
                "hrsh7th/nvim-cmp",
                config = require("plugins.cmp").config(),
                requires = {
                    "onsails/lspkind-nvim",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-nvim-lsp",
                    "saadparwaiz1/cmp_luasnip",
                    "hrsh7th/cmp-buffer",
                    {
                        "tzachar/cmp-tabnine",
                        run = "./install.sh",
                        config = function()
                            require('cmp_tabnine.config'):setup({
                                show_prediction_strength = true
                            })
                        end
                    }
                }
            }

            use {
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup {}
                end
            }

            use {
                "jaredgorski/spacecamp",
                event = "GUIEnter"
            }

            use {
                "justinmk/vim-sneak",
                keys = {
                    { "n", "S" },
                    { "n", "s" }
                }
            }

            use {
                "LionC/nest.nvim",
                config = function()
                    require("mappings").config()
                end
            }

            use {
                "akinsho/toggleterm.nvim",
                config = function()
                    require("plugins.term").config()
                end
            }

            use {
                "cappyzawa/trim.nvim",
                event = "BufWritePre",
                config = function()
                    require("trim").setup({})
                end
            }

            use {
                "hoob3rt/lualine.nvim",
                config = function()
                    require("plugins.lualine").config()
                end
            }

            use {
                "tpope/vim-fugitive",
                cmd = { "G", "Gdiff" }
            }

            use {
                "nvim-telescope/telescope.nvim",
                config = function()
                    require("plugins.telescope").config()
                    require("plugins.telescope").setup_tmp()
                end,
                requires = "BurntSushi/ripgrep",
                after = "refactoring.nvim"
            }

            use {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make"
            }

            use {
                "nvim-treesitter/nvim-treesitter",
                event = "BufRead",
                run = ":TSUpdate",
                config = function()
                    require("plugins.treesitter")
                end
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
                "alvan/vim-closetag",
                ft = { "html", "php" },
                event = "BufWritePre"
            }
        end
    }
end

return M
