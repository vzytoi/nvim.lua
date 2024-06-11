local M = {}

local masonlsp = require('mason-lspconfig')
local format = require('plugins.format').get
local configs = require('plugins.lsp.configs')

local fun = require('utils.fun')

M.keymaps = function()
    vim.g.nmap("gd", vim.lsp.buf.definition)

    vim.g.nmap("gr", vim.lsp.buf.rename)
    vim.g.nmap("ge", vim.lsp.buf.references)

    vim.g.nmap("gh", vim.lsp.buf.hover)

    vim.g.nmap("ga", vim.lsp.buf.code_action)

    vim.g.nmap("gj", function() vim.diagnostic.goto_next({ float = false }) end)
    vim.g.nmap("gk", function() vim.diagnostic.goto_prev({ float = false }) end)
    vim.g.nmap("gf", function() vim.diagnostic.open_float({ header = "", prefix = "" }) end)
end

M.autocmds = function(_, _)
    local group_format = vim.api.nvim_create_augroup("group_format", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            if fun.check_formatting_capability() then
                vim.lsp.buf.format()
            end
        end,
        buffer = 0,
        group = group_format
    })

    -- Je ne me souviens plus pourquoi il faut que formatter.nvim soit exécuté en BufWritePost
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
            if format(vim.bo.filetype) then
                local _ = pcall(nvim.command, "FormatWriteLock")
            end
        end,
        buffer = 0,
        group = group_format
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            vim.lsp.buf.clear_references()
        end,
        buffer = 0,
    })
end

local on_attach = function(client, bufnr)
    M.autocmds()

    -- si un formater est configuré dans formater.nvim
    -- alors je m'assure qu'aucun formater associé au lsp ne soit execute.

    if format and format(u.fun.buf(bufnr, 'filetype')) then
        client.server_capabilities.documentFormattingProvider = false
    end
end

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.offsetEncoding = { "utf-16" }

M.config = function()
    vim.lsp.set_log_level("off")

    vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded"
        },
        virtual_text = {
            severity = require('virtual').grab {
                min = vim.diagnostic.severity.ERROR,
            },
            prefix = u.icons.diagnostics
        }
    })

    local servers = masonlsp.get_installed_servers()

    for _, name in ipairs(servers) do
        require('lspconfig')[name].setup(
            vim.tbl_extend('keep',
                configs.get(name),
                {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    root_dir = require("lspconfig").util.root_pattern('.git'),
                }
            )
        )
    end
end

return M
