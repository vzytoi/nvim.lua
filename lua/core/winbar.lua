local M = {}

local com = require('plugins.lualine.components')
local navic = require('nvim-navic')
local icons = require('nvim-web-devicons')

local filename = function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"

    if not vim.func.is_empty(filename) then

        local file_icon, file_icon_color = icons.get_icon_color(
            filename,
            extension,
            { default = true }
        )

        local hl_group = "FileIconColor" .. extension

        vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
        vim.api.nvim_set_hl(0, "Winbar", { fg = "#6b737f" })

        return " " ..
            "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
    end
end

local gps = function()

    local loc = navic.get_location({})

    if not navic.is_available() or loc == "error" then
        return ""
    end

    if not vim.func.is_empty(loc) then
        return " > " .. loc
    else
        return " "
    end
end

M.get = function()

    if not com.filter() then
        return
    end

    local value = filename()

    if not vim.func.is_empty(value) then
        value = value .. gps()
    end

    local num_tabs = #vim.api.nvim_list_tabpages()

    if num_tabs > 1 and not vim.func.is_empty(value) then
        local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
        value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
    end

    return value

end

M.autocmds = function()
    if vim.fn.has "nvim-0.8" == 1 then
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                vim.opt_local.winbar = filename()
            end
        })
    end
end

return M
