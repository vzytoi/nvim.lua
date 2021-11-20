local M = {}

function M:setup()

    local map = {
        { '<leader>', {
            { 's', function()
                M:run()
            end}
        }}
    }

    return map

end

-- TODO: il faut absolument changer la touche qui valide
-- la completion ... (20/11/2021 19:47:10)

function M:run()

    local function subrange(t, first, last)
         return table.move(t, first, last, 1, {})
    end

    local function split(string, del)

        local result = {};
        for match in (string..del):gmatch("(.-)"..del) do
            table.insert(result, match);
        end
        return result;

    end

    local function callback(_, line)

        local site = split(line, " ")

        local sol = {'google','github','stackoverflow'}

        local is_set = false

        for _, v in pairs(sol) do
            if v == site[1] then
                line = table.concat(
                    subrange(site, 2, #site),
                    " "
                )
                is_set = true
            end
        end

        vim.api.nvim_command(
            string.format("BrowserSearch %s",
                line
            )
        )

        vim.cmd[[call feedkeys("\<esc>")]]

        if is_set then
            if site[1] == 'google' then
                vim.cmd[[call feedkeys("\<cr>")]]
            elseif site[1] == 'github' then
                vim.cmd[[call feedkeys("k\<cr>")]]
            elseif site[1] == 'stackoverflow' then
                vim.cmd[[call feedkeys("jjjj\<cr>")]]
            end
        end

    end

    local opts = {
            mode = 'editor',
            close_on_bufleave = true,
            keymaps = {
                n = {
                    ['q'] = function(popup)
                        popup:close()
                    end,
                    ['<cr>'] = function(popup)
                        popup:close(callback)
                    end
                },
                i = {
                    ['<esc>'] = function(popup)
                        popup:close()
                    end,
                    ['<cr>'] = function(popup)
                        popup:close(callback)
                    end
                }
            },
            prompt = {
                    border = true,
                    numbering = true,
                    title = 'Search',
                    highlight = 'Normal',
                    prompt_highlight = 'Normal'
            },
    }

    require'popfix':new(opts)

end

return M
