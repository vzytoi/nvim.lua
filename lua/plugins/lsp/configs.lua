local M = {}

local configs = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT"
                },
                diagnostics = {
                    globals = { "vim", "u", "P" }
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
