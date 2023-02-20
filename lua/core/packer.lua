local M = {}

M.PB = false

M.config = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    local packer = require("packer")

    if fn.empty(fn.glob(install_path)) > 0 then
        M.PB = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
            install_path })
    end

    packer.init {
        max_jobs = 30
    }

    return packer.startup { function(use)
        use "wbthomason/packer.nvim"
        use "lewis6991/impatient.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-tree/nvim-web-devicons"
        use "tpope/vim-surround"
        use "wellle/targets.vim"
        use "fedepujol/move.nvim"
        use "samjwill/nvim-unception"
        use "eandrju/cellular-automaton.nvim"

        use "vzytoi/virtual.nvim"
        use "vzytoi/quickterm.nvim"
        use "vzytoi/runcode.nvim"

        use 'RishabhRD/popfix'
        use 'RishabhRD/nvim-cheat.sh'
        use "mrjones2014/smart-splits.nvim"
        use "ellisonleao/gruvbox.nvim"
        use "arzg/vim-colors-xcode"
        use "endel/vim-github-colorscheme"
        use "projekt0n/github-nvim-theme"
        use "rafamadriz/friendly-snippets"
        use "AndrewRadev/sideways.vim"

        use { "davidgranstrom/nvim-markdown-preview", cmd = "MarkdownPreview", }
        use { "dstein64/vim-startuptime", cmd = "StartupTime" }
        use { "TimUntersberger/neogit", cmd = "Neogit" }
        use "AckslD/nvim-trevJ.lua"
        use { "romainl/vim-cool", event = "cmdlineenter" }

        use {
            "zbirenbaum/copilot.lua",
            config = function()
                require("copilot").setup()
            end
        }

        use {
            "alvarosevilla95/luatab.nvim",
            requires = "nvim-tree/nvim-web-devicons",
            config = function()
                require("luatab").setup {
                    modified = function() return "" end,
                    windowCount = function() return "" end
                }
            end
        }

        use {
            "cappyzawa/trim.nvim",
            config = function()
                require('trim').setup()
            end
        }


        use {
            "lewis6991/hover.nvim",
            config = function()
                require("hover").setup {
                    init = function()
                        require("hover.providers.lsp")
                        require("hover.providers.man")
                        require("hover.providers.gh")
                    end,
                    title = false
                }
                vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
            end
        }

        use {
            "seandewar/killersheep.nvim",
            cmd = "KillKillKill",
            config = function()
                require("killersheep").setup()
            end
        }

        use {
            "ethanholz/nvim-lastplace",
            config = function()
                require("nvim-lastplace").setup()
            end,
        }

        use {
            "hoob3rt/lualine.nvim",
            config = function() require("plugins.lualine").config() end
        }

        use {
            "LionC/nest.nvim",
            config = function() require("core.keymaps").config() end
        }


        use {
            "ThePrimeagen/harpoon",
            config = function() require("harpoon").setup() end
        }

        use {
            "stevearc/aerial.nvim",
            cmd = "AerialToggle",
            config = function() require("aerial").setup() end
        }


        use {
            "luukvbaal/stabilize.nvim",
            config = function() require "stabilize".setup() end
        }

        use {
            "folke/zen-mode.nvim",
            cmd = "ZenMode",
            config = function() require("zen-mode").setup() end
        }


        use {
            "sindrets/diffview.nvim",
            cmd = "DiffviewOpen",
            config = function() require("diffview").setup() end
        }


        use {
            "mhartington/formatter.nvim",
            config = function() require("plugins.format").config() end
        }



        use {
            "goolord/alpha-nvim",
            config = function()
                require "alpha".setup(require "alpha.themes.dashboard".config)
            end
        }


        use {
            "ray-x/lsp_signature.nvim",
            config = function()
                require("lsp_signature").setup({
                    floating_window = false,
                    hint_prefix = "",
                    hint_scheme = "Comment",
                    floating_window_off_x = 10
                })
            end,
            requires = "neovim/nvim-lspconfig",
        }

        use "L3MON4D3/LuaSnip"

        use {
            "hrsh7th/nvim-cmp",
            config = function()
                require("plugins.cmp").config()
            end,
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "lukas-reineke/cmp-rg",
                "ray-x/cmp-treesitter",
                {
                    "zbirenbaum/copilot-cmp",
                    config = function()
                        require("copilot_cmp").setup()
                    end
                }
            }
        }


        use {
            "nvim-treesitter/nvim-treesitter",
            config = require "plugins.treesitter".config,
            requires = {
                { "windwp/nvim-ts-autotag" },
                { "nvim-treesitter/nvim-treesitter-textobjects" },
                { "RRethy/nvim-treesitter-textsubjects" },
                { "nvim-treesitter/nvim-tree-docs" },
                { "nvim-treesitter/nvim-tree-docs" },
                {
                    "Wansmer/sibling-swap.nvim",
                    requires = { "nvim-treesitter" },
                    config = function()
                        require("sibling-swap").setup({
                            keymaps = {
                                ["<left>"] = "swap_with_left",
                                ["<right>"] = "swap_with_right",
                            }
                        })
                    end,
                },
                {
                    "danymat/neogen",
                    config = function()
                        require('neogen').setup { snippet_engine = "luasnip" }
                    end
                }
            }
        }


        use {
            "nvim-telescope/telescope.nvim",
            config = function()
                require "plugins.telescope".config()
            end,
            requires = {
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    after = "telescope.nvim",
                    run = "make",
                    config = function()
                        require("telescope").load_extension("fzf")
                    end
                },
                { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" },
                {
                    "nvim-telescope/telescope-project.nvim",
                    after = "telescope.nvim",
                    config = function()
                        require("telescope").load_extension("project")
                    end
                },
                {
                    "smartpde/telescope-recent-files",
                    after = "telescope.nvim",
                    config = function()
                        require("telescope").load_extension("recent_files")
                    end
                }
            },
        }

        use {
            "williamboman/mason.nvim",
            config = function() require("mason").setup() end,
            -- requires = {
            --     { "mfussenegger/nvim-lint",
            --         config = function() require("core.linter").config() end },
            -- }
        }

        use "felipevolpone/mono-theme"

        use {
            "https://github.com/nat-418/boole.nvim",
            config = function()
                require("boole").setup {
                    mappings = {
                        increment = "<up>",
                        decrement = "<down>",
                    },
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
                config = function() require("lsp-colors").setup() end,
            },
            cmd = "TroubleToggle"
        }

        use {
            "nvim-tree/nvim-tree.lua",
            config = function() require("plugins.nvimtree").config() end,
        }

        use {
            "neovim/nvim-lspconfig",
            config = function() require("plugins.lsp").config() end,
            requires = "williamboman/mason-lspconfig.nvim"
        }

        use({
            "dnlhc/glance.nvim",
            config = function()
                require("glance").setup()
            end,
        })

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
            'altermo/ultimate-autopair.nvim',
            event = { 'InsertEnter', 'CmdlineEnter' },
            config = function()
                require('ultimate-autopair').setup {}
            end,
        }

        --[[ use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup()
            end,
            keys = {
                { "i", "(" },
                { "i", "[" },
                { "i", "{" },
                { "i", '"' },
                { "i", '"' },
                { "i", "<BS>" },
            }
        } ]]
        use {
            "ggandor/leap.nvim",
            keys = {
                { "n", "S" },
                { "n", "s" }
            },
            config = function()
                require("leap").set_default_keymaps()
            end
        }

        use {
            "akinsho/toggleterm.nvim",
            cmd = "ToggleTerm",
            config = function()
                require("plugins.toggleterm").config()
            end,
        }

        if M.PB then
            packer.sync()
        end
    end,
        config = {
            display = {
                open_fn = require("packer.util").float
            }
        }
    }
end

return M
