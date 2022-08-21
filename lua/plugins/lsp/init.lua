local M = {}

local masonlsp = require('mason-lspconfig')
local servers_lst = require('mason-lspconfig.mappings.server')
local format = require('plugins.format').get
local configs = require('plugins.lsp.configs')

M.keymaps = function()

    vim.g.nmap("gd", function() vim.lsp.buf.definition() end)

    vim.g.nmap("gr", function() vim.lsp.buf.rename() end)
    vim.g.nmap("gR", "<cmd>Telescope lsp_references<cr>")

    vim.g.nmap("gh", function() vim.lsp.buf.hover() end)

    vim.g.nmap("ga", function() vim.api.nvim_command('CodeActionMenu') end)

    vim.g.nmap("gj", function() vim.diagnostic.goto_next({ float = false }) end)
    vim.g.nmap("gk", function() vim.diagnostic.goto_prev({ float = false }) end)
    vim.g.nmap('gt', function() vim.api.nvim_command('TroubleToggle') end)
    vim.g.nmap("gf", function() vim.diagnostic.open_float({ header = "", prefix = "" }) end)
end

M.autocmds = function()

    require "plugins.lsp.vt".autocmds()

    vim.g.autocmd("BufWritePre", {
        callback = function()
            if vim.fun.capabilities('format', 0) then
                vim.lsp.buf.format()
            end
        end,
        buffer = 0
    })

    vim.g.autocmd("BufWritePost", {
        callback = function()
            if format(vim.bo.filetype) then
                if not vim.fun.file_empty(vim.fn.bufnr()) then
                    vim.api.nvim_command("FormatWrite")
                end
            end
        end,
        buffer = 0
    })

    vim.g.autocmd("CursorHold", {
        callback = function()
            if vim.fun.capabilities('hi', 0) then
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

    require 'nvim-navic'.attach(client, bufnr)
    M.autocmds()

    -- si un formatter est configuré dans formatter.nvim
    -- alors je m'assure qu'aucun formatter associé au lsp ne soit executé.
    if format(vim.fun.buf(bufnr, 'filetype')) then
        client.server_capabilities.documentFormattingProvider = false
    end

end

local capabilities = require 'cmp_nvim_lsp'.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

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
            severity = { min = vim.diagnostic.severity.ERROR },
            prefix = vim.icons.diagnostics
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
