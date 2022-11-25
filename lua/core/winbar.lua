local M = {}

local devicons = require("nvim-web-devicons")
local navic = require("nvim-navic")

M.filename = function()
    local fn = vim.fn.expand "%:t"
    local ext = vim.fn.expand "%:e"

    if not u.fun.is_empty(fn) then
        local icon, color = devicons.get_icon_color(fn, ext, { default = true })
        local hl_group = "FileIconColor" .. ext

        vim.api.nvim_set_hl(0, hl_group, { fg = color })

        local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
        vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

        return " " .. "%#" .. hl_group .. "#" .. icon .. "%*" .. " " .. "%#Winbar#" .. fn .. "%*"
    end

    return ""
end

M.gps = function()
    local gps = navic.get_location()

    if not navic.is_available() or gps == "error" or u.fun.is_empty(gps) then
        return ""
    end

    return "%#NavicSeparator# >%* " .. gps
end

M.set = function()
    local value = M.filename() .. M.gps()

    vim.api.nvim_set_option_value("winbar", value, { scope = "local" })
end

M.autocmds = function()
    vim.api.nvim_create_autocmd(
        { "CursorHoldI", "CursorHold", "BufWinEnter",
            "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
        { callback = function()
            if not u.ft.is_disabled('winbar') then
                -- require("core.winbar").set()
            end
        end }
    )
end

return M
