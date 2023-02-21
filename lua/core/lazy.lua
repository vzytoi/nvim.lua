local M = {}


M.config = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup {
        { "vzytoi/virtual.nvim",   lazy = true },
        { "vzytoi/quickterm.nvim", lazy = true },
        { "vzytoi/runcode.nvim",   lazy = true },

        {
            "mhartington/formatter.nvim",
            config = function()
                vim.defer_fn(function()
                    require("plugins.format").config()
                end, 0
                )
            end
        },


        {
            "nvim-tree/nvim-tree.lua",
            config = function()
                vim.defer_fn(function()
                    require("plugins.nvimtree").config()
                end, 0)
            end
        },

        "endel/vim-github-colorscheme",
        { "felipevolpone/mono-theme",             enabled = false },


        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",

        "L3MON4D3/LuaSnip",

        "tpope/vim-surround",
        "wellle/targets.vim",
        "fedepujol/move.nvim",
        "samjwill/nvim-unception",
        "mrjones2014/smart-splits.nvim",
        "AckslD/nvim-trevJ.lua",
        "ethanholz/nvim-lastplace",
        "cappyzawa/trim.nvim",
        "dnlhc/glance.nvim",
        "luukvbaal/stabilize.nvim",

        { "eandrju/cellular-automaton.nvim",      cmd = "CellularAutomaton" },
        { "AndrewRadev/sideways.vim",             cmd = { "SidewaysLeft", "SidewaysRight" } },
        { "zbirenbaum/copilot.lua",               lazy = true },
        { "ThePrimeagen/harpoon",                 lazy = true },
        { "davidgranstrom/nvim-markdown-preview", cmd = "MarkdownPreview" },
        { "dstein64/vim-startuptime",             cmd = "StartupTime" },
        { "TimUntersberger/neogit",               cmd = "Neogit" },
        { "romainl/vim-cool",                     event = "cmdlineenter" },
        { "seandewar/killersheep.nvim",           cmd = "KillKillKill" },
        { "stevearc/aerial.nvim",                 cmd = "AerialToggle" },
        { "folke/zen-mode.nvim",                  cmd = "ZenMode", },
        { "sindrets/diffview.nvim",               cmd = "DiffviewOpen", },
        { 'altermo/ultimate-autopair.nvim',       event = { 'InsertEnter', 'CmdlineEnter' } },
        { "xiyaowong/accelerated-jk.nvim",        keys = { { "n", "j" }, { "n", "k" } } },

        {
            "folke/persistence.nvim",
            event = "BufReadPre",
            module = "persistence",
            config = function()
                require("persistence").setup()
            end
        },


        {
            "williamboman/mason.nvim",
            config = function() require("mason").setup() end,
        },


        {
            "ggandor/leap.nvim",
            config = function()
                require("leap").set_default_keymaps()
            end
        },



        {
            "folke/trouble.nvim",
            cmd = "TroubleToggle",
            dependencies = "folke/lsp-colors.nvim"
        },


        {
            "akinsho/toggleterm.nvim",
            cmd = "ToggleTerm",
            config = function()
                require("plugins.toggleterm").config()
            end
        },


        {
            "alvarosevilla95/luatab.nvim",
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require("luatab").setup {
                    modified = function() return "" end,
                    windowCount = function() return "" end
                }
            end
        },


        {
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
        },



        {
            "hoob3rt/lualine.nvim",
            event = "ColorScheme",
            config = function() require("plugins.lualine").config() end
        },

        {
            "LionC/nest.nvim",
            config = function() require("core.keymaps").config() end
        },


        {
            "goolord/alpha-nvim",
            config = function()
                require "alpha".setup(require "alpha.themes.dashboard".config)
            end
        },


        {
            "ray-x/lsp_signature.nvim",
            config = function()
                require("lsp_signature").setup({
                    floating_window = false,
                    hint_prefix = "",
                    hint_scheme = "Comment",
                    floating_window_off_x = 10
                })
            end,
            dependencies = "neovim/nvim-lspconfig",
        },


        {
            "hrsh7th/nvim-cmp",
            config = function()
                require("plugins.cmp").config()
            end,
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "lukas-reineke/cmp-rg",
                "ray-x/cmp-treesitter",
                "zbirenbaum/copilot-cmp",
            }
        },


        {
            "nvim-treesitter/nvim-treesitter",
            config = require "plugins.treesitter".config,
            dependencies = {
                "windwp/nvim-ts-autotag",
                "nvim-treesitter/nvim-treesitter-textobjects",
                "RRethy/nvim-treesitter-textsubjects",
                "nvim-treesitter/nvim-tree-docs",
                "nvim-treesitter/nvim-tree-docs",
                {
                    "Wansmer/sibling-swap.nvim",
                    config = function()
                        require("sibling-swap").setup {
                            keymaps = {
                                ["<left>"] = "swap_with_left",
                                ["<right>"] = "swap_with_right",
                            }
                        }
                    end,
                },
                {
                    "danymat/neogen",
                    config = function()
                        require('neogen').setup { snippet_engine = "luasnip" }
                    end
                }
            }
        },


        {
            "nvim-telescope/telescope.nvim",
            config = function()
                require "plugins.telescope".config()
            end,
            keys = "<leader>f",
            dependencies = {
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                    config = function()
                        require("telescope").load_extension("fzf")
                    end
                },
                "nvim-telescope/telescope-symbols.nvim",
                {
                    "nvim-telescope/telescope-project.nvim",
                    config = function()
                        require("telescope").load_extension("project")
                    end
                },
                {
                    "smartpde/telescope-recent-files",
                    config = function()
                        require("telescope").load_extension("recent_files")
                    end
                }
            },
        },

        {
            "nat-418/boole.nvim",
            config = function()
                require("boole").setup {
                    mappings = {
                        increment = "<up>",
                        decrement = "<down>",
                    },
                }
            end
        },

        {
            "neovim/nvim-lspconfig",
            config = function() require("plugins.lsp").config() end,
            dependencies = "williamboman/mason-lspconfig.nvim"
        },

        {
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
        },

        {
            "rktjmp/paperplanes.nvim",
            cmd = "PP",
            config = function()
                require("paperplanes").setup({
                    provider = "paste.rs"
                })
            end
        },

        {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup({
                    ignore = "^$"
                })
            end,
            dependencies = {
                "JoosepAlviste/nvim-ts-context-commentstring",
            },
            event = { "BufRead", "BufNewFile" },
        },


    }
end

return M
