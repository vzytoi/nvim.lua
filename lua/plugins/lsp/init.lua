local M = {}

local masonlsp = require('mason-lspconfig')
-- local servers_lst = require('mason-lspconfig.mappings.server')
local format = require('plugins.format').get
local configs = require('plugins.lsp.configs')

M.keymaps = function()

    vim.g.nmap("gd", vim.lsp.buf.definition)
    vim.g.nmap("gD", "<cmd>Glance definitions<CR>")

    vim.g.nmap("gr", vim.lsp.buf.rename)
    vim.g.nmap("gR", "<cmd>Glance references<CR>")

    vim.g.nmap("gh", vim.lsp.buf.hover)

    vim.g.nmap("ga", vim.lsp.buf.code_action)

    vim.g.nmap("gj", function() vim.diagnostic.goto_next({ float = false }) end)
    vim.g.nmap("gk", function() vim.diagnostic.goto_prev({ float = false }) end)
    vim.g.nmap('gt', function() nvim.command('TroubleToggle') end)
    vim.g.nmap("gf", function() vim.diagnostic.open_float({ header = "", prefix = "" }) end)
end

M.autocmds = function()

    vim.g.autocmd("BufWritePre", {
        callback = function()
            if u.fun.capabilities('format', 0) then
                vim.lsp.buf.format()
            end
        end,
        buffer = 0
    })

    vim.g.autocmd("BufWritePost", {
        callback = function()
            if format(vim.bo.filetype) then
                local _ = pcall(nvim.command, "FormatWriteLock")
            end
        end,
        buffer = 0
    })

    vim.g.autocmd("CursorHold", {
        callback = function()
            if u.fun.capabilities('hi', 0) then
                vim.lsp.buf.document_highlight()
            end
        end,
        buffer = 0
    })

    vim.g.autocmd("CursorMoved", {
        callback = function()
            vim.lsp.buf.clear_references()
        end,
        buffer = 0
    })

end

local on_attach = function(client, bufnr)

    M.autocmds()

    require "lsp_signature".on_attach({}, bufnr)

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    -- si un formatter est configuré dans formatter.nvim
    -- alors je m'assure qu'aucun formatter associé au lsp ne soit executé.
    if format(u.fun.buf(bufnr, 'filetype')) then
        client.server_capabilities.documentFormattingProvider = false
    end

end

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

M.config = function()

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
                    root_dir = vim.loop.cwd
                }
            )
        )

    end

end

return M
