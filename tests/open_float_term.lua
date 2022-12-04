local bufnr = vim.api.nvim_create_buf(false, true)

local width = vim.opt.columns:get()
local height = vim.opt.lines:get()
local padding = 25

local winh = vim.api.nvim_open_win(bufnr, false,
    {
        relative = 'editor',
        col = padding / 2,
        row = padding / 2,
        width = vim.fn.round(width / 3),
        height = vim.fn.round(height / 3),
        border = "rounded",
        focusable = true,
        title = "RunTests",
    })

vim.api.nvim_set_current_win(winh)

local _ = vim.fn.termopen("lua\n", {
    detach = 1,
})
