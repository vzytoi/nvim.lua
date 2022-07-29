local M = {}

local function scandir(directory)

    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')

    if pfile ~= nil then
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
    else
        return false
    end

    return vim.list_slice(t, 3, #t)
end

local autocmd = vim.api.nvim_create_autocmd

local function on_attach(client, bufnr)

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

    if client.supports_method("textDocument/formatting") then
        autocmd("BufWritePre", {
            callback = function() vim.lsp.buf.format() end,
            buffer = 0
        })
    else
        autocmd("BufWritePost", {
            callback = function() vim.api.nvim_command('FormatWrite') end,
            buffer = 0
        })
    end

    autocmd("CursorHold", {
        callback = function()
            if client.supports_method("textDocument/documentHighlight") then
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
    }
}

M.config = function()

    local servers = scandir(vim.fn.stdpath('data') .. '/lsp_servers/')

    require('nvim-lsp-installer').setup {
        ensure_installed = servers,
        automatic_installation = true
    }

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

    local capabilities = require("cmp_nvim_lsp").update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    for _, lsp in pairs(servers) do

        local s = setup[lsp]

        if s == nil then
            s = {}
        end

        require("lspconfig")[lsp].setup(
            vim.tbl_extend('keep', s, {
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = vim.loop.cwd
            })
        )
    end
end

return M
