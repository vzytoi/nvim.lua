local M = {}

local autocmd = vim.api.nvim_create_autocmd

M.close = function()
    local gclose = vim.api.nvim_create_augroup("closeWhenLast", {clear = true})

    local fts = {
        "packer",
        "git-commit",
        "coc-explorer",
        "fugitive",
        "startuptime",
        "qf",
        "diff",
        "toggleterm"
    }

    local apply = function(ft)
        vim.api.nvim_create_autocmd(
            "BufEnter",
            {
                callback = function()
                    if vim.fn.winnr("$") == 1 and vim.bo.filetype == ft then
                        vim.api.nvim_command("q")
                    end
                end,
                group = gclose
            }
        )
    end

    for _, ft in ipairs(fts) do
        apply(ft)
    end
end

M.lsp_highlight = function()
    autocmd(
        "CursorHold",
        {
            callback = function()
                vim.lsp.buf.document_highlight()
            end
        }
    )

    autocmd(
        "CursorMoved",
        {
            callback = function()
                vim.lsp.buf.clear_references()
            end
        }
    )
end

M.config = function()
    M.close()

    autocmd(
        "Colorscheme",
        {
            pattern = "*",
            callback = function()
                require("plugins.lualine")
                require("colors").config()
            end,
            group = vim.api.nvim_create_augroup("colorschemeLoader", {clear = true})
        }
    )

    autocmd(
        "BufReadPost",
        {
            callback = function()
                local size = vim.fn.getfsize(vim.fn.expand("%"))
                if size >= 1000000 then
                    for hl_name, _ in pairs(vim.api.nvim__get_hl_defs(0)) do
                        vim.api.nvim_set_hl(0, hl_name, {})
                    end
                elseif size >= 500000 then
                    vim.api.nvim_command("silent! TSBufDisable highlight")
                end
            end
        }
    )

    autocmd(
        "FileType",
        {
            pattern = "gitcommit",
            callback = function()
                require("cmp").setup.buffer({enable = false})
            end
        }
    )

    autocmd(
        "BufEnter",
        {
            command = "silent! lcd %:p:h"
        }
    )

    autocmd(
        "VimResized",
        {
            command = "wincmd ="
        }
    )

    autocmd(
        "BufWritePost",
        {
            pattern = {"*.lua", "*.py", "*.js"},
            callback = function()
                vim.api.nvim_command("FormatWrite")
            end
        }
    )

    autocmd(
        "InsertLeave",
        {
            callback = function()
                vim.opt.relativenumber = true
            end
        }
    )

    autocmd(
        "InsertEnter",
        {
            callback = function()
                vim.opt.relativenumber = false
            end
        }
    )

    autocmd(
        "FileType",
        {
            pattern = {"gitcommit", "markdown", "text"},
            callback = function()
                vim.opt_local.spell = true
            end
        }
    )
end
return M
