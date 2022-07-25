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

local function on_attach(_, bufnr)

    local map = require('mappings').map

    map()("gr", function() vim.lsp.buf.rename() end)
    map()("gh", function() vim.lsp.buf.hover() end)
    map()("gd", function() vim.lsp.buf.definition() end)
    map()("gR", function() vim.lsp.buf.references() end)
    map()("gn", function() vim.lsp.diagnostic.goto_next() end)
    map()("gp", function() vim.lsp.diagnostic.goto_prev() end)

end

M.autocmds = function()
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            vim.lsp.buf.document_highlight()
        end
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            vim.lsp.buf.clear_references()
        end
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

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    )

    local servers = scandir(vim.fn.stdpath('data') .. '/lsp_servers/')
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    require('nvim-lsp-installer').setup {
        ensure_installed = servers,
        automatic_installation = true
    }

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
