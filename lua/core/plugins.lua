local M = {}

function M.config()

    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        PB = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
            install_path })
    end

    return require("packer").startup { function(use)

        use "lewis6991/impatient.nvim"
        use "wbthomason/packer.nvim"
        use "nvim-lua/plenary.nvim"
        use "tpope/vim-surround"
        use "tpope/vim-sleuth"
        use "wellle/targets.vim"
        use "farmergreg/vim-lastplace"
        use "fedepujol/move.nvim"
        use "antoinemadec/FixCursorHold.nvim"
        use "ellisonleao/gruvbox.nvim"
        use "stevearc/dressing.nvim"
        use "mfussenegger/nvim-lint"

        use {
            "rcarriga/nvim-notify",
            config = function()
                require("notify").setup {
                    stages = "fade",
                    fps = 60,
                    timeout = 0
                }
            end
        }

        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require 'plugins.gitsigns'.config()
            end
        }

        use {
            "SmiteshP/nvim-navic",
            config = function()
                require("nvim-navic").setup()
            end
        }

        use {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end
        }

        use {
            "ThePrimeagen/harpoon",
            config = function()
                require("harpoon").setup()
            end
        }

        use {
            "LionC/nest.nvim",
            config = function()
                require("core.keymaps").config()
            end,
        }

        use {
            "luukvbaal/stabilize.nvim",
            config = function()
                require("stabilize").setup()
            end
        }

        use {
            "chrisbra/NrrwRgn",
            cmd = { "NarrowRegion", "NarrowWindow" }
        }

        use {
            "ahmedkhalf/project.nvim",
            config = function()
                require "project_nvim".setup {
                    detection_methods = { "!lua" }
                }
            end
        }

        use {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup()
            end,
            {
                "folke/lsp-colors.nvim",
                config = function()
                    require("lsp-colors").setup()
                end,
            },
            cmd = "TroubleToggle"
        }

        use {
            "windwp/nvim-spectre",
            module = "spectre"
        }

        use {
            "romainl/vim-cool",
            event = "cmdlineenter"
        }

        use {
            "nvim-telescope/telescope.nvim",
            config = function()
                require("plugins.telescope").config()
            end,
            requires = {
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    run = "make"
                }
            },
            keys = { { "n", "<leader>f" } }
        }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require("plugins.tree").config()
            end,
            cmd = "NvimTreeToggle"
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("plugins.treesitter").config()
            end
        }

        use { "windwp/nvim-ts-autotag", after = "nvim-treesitter", }
        use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
        use { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" }

        use {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            config = function()
                require("plugins.cmp").config()
            end,
            requires = "onsails/lspkind-nvim"
        }

        use { "hrsh7th/cmp-path", after = "nvim-cmp" }
        use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }
        use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
        use {
            "tzachar/cmp-tabnine",
            run = "./install.sh",
            config = function()
                require("cmp_tabnine.config"):setup({
                    show_prediction_strength = true
                })
            end,
            after = "nvim-cmp"
        }
        use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }

        use {
            "L3MON4D3/LuaSnip",
            config = function() require("luasnip.loaders.from_snipmate").lazy_load() end,
            after = "nvim-cmp"
        }

        use {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require("plugins.format").config()
            end
        }

        use {
            "neovim/nvim-lspconfig",
            config = function()
                require("plugins.lsp").config()
            end,
            requires = {
                "williamboman/mason-lspconfig.nvim",
            }
        }

        use {
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup({
                    text = { spinner = "dots_negative" },
                    timer = { spinner_rate = 100 },
                    fmt = {
                        leftpad = false,
                        task = function(task_name, message, percentage)
                            return ""
                        end
                    },
                    sources = {
                        ["null-ls"] = {
                            ignore = true
                        }
                    }
                })
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
            end,
            keys = { { "n", "j" }, { "n", "k" } }
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
                require("Comment").setup({
                    ignore = "^$"
                })
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
            module = "persistence",
            config = function()
                require("persistence").setup()
            end
        }

        use {
            "dstein64/vim-startuptime",
            cmd = "StartupTime"
        }

        use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup()
            end,
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
            "akinsho/toggleterm.nvim",
            config = function()
                require("plugins.term").config()
            end,
            cmd = "ToggleTerm"
        }

        use {
            "cappyzawa/trim.nvim",
            event = "BufWritePre",
            config = function()
                require("trim").setup()
            end,
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

        if PB then
            require("packer").sync()
        end

    end
    }
end

return M
