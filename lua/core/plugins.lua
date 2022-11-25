local M = {}

M.config = function()

    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
        PB = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
            install_path })
    end

    return require("packer").startup { function(use)

        use "wbthomason/packer.nvim"
        use "lewis6991/impatient.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-tree/nvim-web-devicons"

        use "tpope/vim-surround"
        use "wellle/targets.vim"
        use "fedepujol/move.nvim"
        use "antoinemadec/FixCursorHold.nvim"
        use "stevearc/dressing.nvim"
        use "smartpde/telescope-recent-files"
        use "samjwill/nvim-unception"
        use "mbbill/undotree"

        use "ellisonleao/gruvbox.nvim"
        use "arzg/vim-colors-xcode"

        use {
            'ethanholz/nvim-lastplace',
            config = function()
                require 'nvim-lastplace'.setup {}
            end
        }

        use {
            'goolord/alpha-nvim',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = function()
                require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
            end
        }

        use {
            "LionC/nest.nvim",
            config = function()
                require "core.keymaps".config()
            end
        }

        use {
            "SmiteshP/nvim-navic",
            config = function()
                require("nvim-navic").setup {
                    highlight = true
                }
            end,
            requires = "neovim/nvim-lspconfig",
        }

        use {
            "ray-x/lsp_signature.nvim",
            config = function()
                require("lsp_signature").setup({
                    floating_window = false,
                    hint_prefix = "",
                    hint_scheme = "Comment",
                })
            end,
            requires = "neovim/nvim-lspconfig",
        }

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
                require("cmp_tabnine.config"):setup({ show_prediction_strength = false })
            end,
            after = "nvim-cmp"
        }
        use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
        use { "lukas-reineke/cmp-rg", after = "nvim-cmp" }

        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require "plugins.treesitter".config()
            end
        }

        use { "windwp/nvim-ts-autotag", after = "nvim-treesitter", }
        use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
        use { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" }
        use { 'nvim-treesitter/nvim-tree-docs', after = "nvim-treesitter" }

        use {
            "nvim-telescope/telescope.nvim",
            keys = "<leader>f",
            cmd = "Telescope",
            package = "telescope",
            config = function()
                require "plugins.telescope".config()
            end,

            requires = {
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                { 'nvim-telescope/telescope-symbols.nvim' },
                { "nvim-telescope/telescope-project.nvim" }
            },
        }

        use {
            "williamboman/mason.nvim",
            config = function()
                require "mason".setup()
            end,
            requires = {
                {
                    "mfussenegger/nvim-lint",
                    config = function()
                        require('core.linter').config()
                    end
                },
            }
        }

        use "mfussenegger/nvim-dap"
        use "rcarriga/nvim-dap-ui"
        use {
            "jayp0521/mason-nvim-dap.nvim",
            config = function()
                require("mason").setup()
                require("mason-nvim-dap").setup({
                    automatic_setup = true,
                })
                require 'mason-nvim-dap'.setup_handlers()
            end
        }


        use {
            'https://github.com/nat-418/boole.nvim',
            config = function()
                require('boole').setup {
                    mappings = {
                        increment = '<up>',
                        decrement = '<down>'
                    },
                }
            end
        }

        use {
            "ThePrimeagen/harpoon",
            config = function()
                require "harpoon".setup()
            end
        }

        use {
            "luukvbaal/stabilize.nvim",
            config = function()
                require "stabilize".setup()
            end
        }

        use {
            "chrisbra/NrrwRgn",
            cmd = { "NarrowRegion", "NarrowWindow" }
        }

        use {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup()
            end,
            {
                "folke/lsp-colors.nvim",
                config = function()
                    require "lsp-colors".setup()
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
            "nvim-tree/nvim-tree.lua",
            requires = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require('plugins.nvimtree').config()
            end,
            cmd = "NvimTreeToggle"
        }

        use {
            "L3MON4D3/LuaSnip",
            config = function()
                require("luasnip.loaders.from_snipmate").lazy_load()
            end,
            after = "nvim-cmp"
        }

        use {
            "mhartington/formatter.nvim",
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
                "hrsh7th/cmp-nvim-lsp"

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
                        task = function()
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
                    provider = "paste.rs"
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
                require("diffview").setup {}
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
            },
            event = { "BufRead", "BufNewFile" },
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
            keys = {
                { "i", "(" },
                { "i", "[" },
                { "i", "{" },
                { "i", "'" },
                { "i", '"' },
                { "i", "<BS>" },
            }
        }

        use {
            "ggandor/leap.nvim",
            keys = {
                { "n", "S" },
                { "n", "s" }
            },
            config = function()
                require('leap').set_default_keymaps()
            end
        }

        use {
            "akinsho/toggleterm.nvim",
            config = function()
                require("plugins.toggleterm").config()
            end,
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

        use {
            "stevearc/aerial.nvim",
            config = function() require('aerial').setup() end,
            cmd = { "AerialToggle" }
        }

        if PB then
            require("packer").sync()
        end

    end,
        config = {
            display = {
                open_fn = require('packer.util').float
            }
        }
    }
end

return M
