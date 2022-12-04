local bufnr = vim.api.nvim_create_buf(false, true)

local width = 20

vim.api.nvim_open_win(bufnr, false,
    { relative = 'editor', row = vim.fn.winheight(0) - 5, col = vim.fn.winwidth(0) - 25, width = width, height = 3,
        noautocmd = true,
        border = "rounded",
        focusable = false,
        title = "RunCode",
        style = "minimal" })

vim.api.nvim_buf_set_lines(bufnr, 1, 2, false, { string.rep(" ", (width - 10) / 2) .. "Loading..." })
