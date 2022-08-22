local M = {}

local configs = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT"
                },
                diagnostics = {
                    globals = { "vim", "u", "nvim" }
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

M.get = function(name)
    return configs[name] or {}
end

return M
