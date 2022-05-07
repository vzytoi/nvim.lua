local M = {}

M.setColorscheme = function()
    vim.api.nvim_create_autocmd(
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
end

M.handleBigFiles = function()
    vim.api.nvim_create_autocmd(
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
end

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

    local function apply(ft)
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
    vim.api.nvim_create_autocmd(
        "CursorHold",
        {
            callback = function()
                vim.lsp.buf.document_highlight()
            end
        }
    )

    vim.api.nvim_create_autocmd(
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
    M.setColorscheme()
    M.handleBigFiles()

    vim.api.nvim_create_autocmd(
        "FileType",
        {
            pattern = "gitcommit",
            callback = function()
                require("cmp").setup.buffer({enable = false})
            end
        }
    )

    vim.api.nvim_create_autocmd("BufEnter", {command = "silent! lcd %:p:h"})
    vim.api.nvim_create_autocmd("VimResized", {command = "wincmd ="})

    M.formatter = vim.api.nvim_create_augroup("formatter", {clear = true})

    vim.api.nvim_create_autocmd(
        "BufWritePost",
        {
            pattern = {"*.lua", "*.py", "*.js"},
            callback = function()
                vim.api.nvim_command("FormatWrite")
            end,
            group = M.formatter
        }
    )
end

return M
