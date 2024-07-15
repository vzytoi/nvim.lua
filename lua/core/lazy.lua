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

    local settings = {
        performance = {
            cache = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/lazy/cache",
                disable_events = { "UIEnter", "BufReadPre" },
                ttl = 3600 * 24 * 2,
            },
            reset_packpath = true,
            rtp = {
                reset = true,
                paths = {},
            },
        }
    }

    local plugins = {
        { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
        { "vzytoi/virtual.nvim" },
        { "vzytoi/quickterm.nvim",           lazy = true },
        { "vzytoi/runcode.nvim" },
        { "romainl/vim-cool",                event = "cmdlineenter" },
        { "AndrewRadev/sideways.vim",        cmd = { "SidewaysLeft", "SidewaysRight" } },
        { "ThePrimeagen/harpoon",            lazy = true },
        { "m4xshen/autoclose.nvim",          lazy = true,                              event = "InsertEnter" },
        { 'akinsho/git-conflict.nvim',       config = true,                            main = "git-conflict", },
        {
            "williamboman/mason.nvim",
            lazy = true,
            config = true,
            main =
            "mason"
        },
        "lunacookies/vim-colors-xcode",
        { "mrjones2014/smart-splits.nvim", lazy = true, event = "VeryLazy" },

        {
            "NeogitOrg/neogit",
            dependencies = {
                "sindrets/diffview.nvim",
            },
            config = function()
                require("neogit").setup {
                    integrations = {
                        diffview = true
                    }
                }
            end
        },

        {
            "kylechui/nvim-surround",
            version = "*",
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({})
            end
        },

        {
            "fedepujol/move.nvim",
            config = function() require('move').setup({}) end,
        },

        "Wansmer/treesj",
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "wellle/targets.vim",
        "AckslD/nvim-trevJ.lua",
        "farmergreg/vim-lastplace",
        "cappyzawa/trim.nvim",
        "felipevolpone/mono-theme",
        require("plugins.telescope").load,
        require("plugins.treesitter").load,
        require("plugins.nvimtree").load,
        require("plugins.lualine").load,
        require("plugins.cmp").load,

        {
            'Bekaboo/dropbar.nvim',
            config = function()
                require("dropbar").setup({
                    icons = {
                        ui = {
                            bar = {
                                separator = " > "
                            }
                        }
                    }
                })
            end,
            dependencies = "nvim-tree/nvim-web-devicons"
        },

        {
            "gbprod/stay-in-place.nvim",
            config = function()
                require("stay-in-place").setup {}
            end
        },

        {
            "chrisgrieser/nvim-various-textobjs",
            config = function()
                require("various-textobjs").setup({ useDefaultKeymaps = true })
            end,
            lazy = true,
            event = "VeryLazy"
        },


        {
            "mhartington/formatter.nvim",
            config = function()
                vim.defer_fn(function()
                    require("plugins.format").config()
                end, 0
                )
            end,
            lazy = true,
            event = "VeryLazy"
        },

        {
            "folke/persistence.nvim",
            event = "BufReadPre",
            module = "persistence",
            main = "persistence",
            config = true,
        },

        {
            "ggandor/leap.nvim",
            config = function()
                require("leap").set_default_keymaps()
            end
        },

        {
            "akinsho/toggleterm.nvim",
            cmd = "ToggleTerm",
            config = function()
                require("plugins.toggleterm").config()
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
            lazy = true,
            event = { "BufReadPost", "BufAdd", "BufNewFile" },
            config = function() require("plugins.lsp").config() end,
            dependencies = "williamboman/mason-lspconfig.nvim",
        },

        {
            "j-hui/fidget.nvim",
        },

        "JoosepAlviste/nvim-ts-context-commentstring",
    }

    require("lazy").setup(plugins, settings)
end

return M
