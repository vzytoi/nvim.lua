local M = {}

local autocmd = vim.api.nvim_create_autocmd

local navic = require('nvim-navic')
local cmp_lsp = require("cmp_nvim_lsp")
local mason_lsp = require('mason-lspconfig')
local mason_servers = require('mason-lspconfig.mappings.server')
local format = require('plugins.format').get()

local function on_attach(client, bufnr)

    navic.attach(client, bufnr)

    vim.g.nmap("gr", function() vim.lsp.buf.rename() end)
    vim.g.nmap("gh", function() vim.lsp.buf.hover() end)
    vim.g.nmap("gd", function() vim.lsp.buf.definition() end)
    vim.g.nmap("gR", function() vim.lsp.buf.references() end)
    vim.g.nmap("gn", function() vim.diagnostic.goto_next({ float = false }) end)
    vim.g.nmap("gp", function() vim.diagnostic.goto_prev({ float = false }) end)

    vim.g.nmap("gf", function()
        vim.diagnostic.open_float({
            header = "",
            prefix = ""
        })
    end)

    if vim.func.capabilities('format', bufnr) or vim.tbl_contains(format, vim.bo.filetype) then
        autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format()
            end,
            buffer = 0
        })
    end

    autocmd("CursorHold", {
        callback = function()
            if vim.func.capabilities('hi', bufnr) then
                vim.lsp.buf.document_highlight()
            end
        end,
        buffer = 0
    })

    autocmd("CursorMoved", {
        callback = function()
            vim.lsp.buf.clear_references()
        end,
        buffer = 0
    })

end

local capabilities = cmp_lsp.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local setup = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT"
                },
                diagnostics = {
                    globals = { "vim" }
                },
                workspaces = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true
                    }
                },
                telemetry = {
                    enable = false
                }
            }
        }
    },
    ['*'] = {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = vim.loop.cwd
    }
}

M.config = function()

    local path = vim.fn.stdpath('data') .. '/mason/packages'

    local servers = vim.tbl_map(function(e)
        return mason_servers.package_to_lspconfig[e]
    end, vim.func.scandir(path))

    mason_lsp.setup { ensure_installed = servers }

    vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded"
        },
        virtual_text = {
            severity = { min = vim.diagnostic.severity.WARN }
        }
    })

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'rounded'

        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    for _, lsp in pairs(servers) do
        require('lspconfig')[lsp].setup(
            vim.tbl_extend('keep', setup[lsp] or {}, setup['*'])
        )
    end
end

return M
