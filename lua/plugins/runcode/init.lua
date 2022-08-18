-- @author Cyprien Henner
local M = {}

local ls = require('plugins.runcode.commands')

local write = {
    -- @description permet de clear l'entièreté du text
    -- dans un buffer donné. Est utilisé lorsque RunCode
    -- est exécuté pour un buffer pour lequel une fenêtre
    -- RunCode avait déjà été ouverte
    clear = function(nr)
        vim.api.nvim_buf_set_lines(nr, 0, -1, true, {})
    end,
    -- @description ajouté du text à un buffer, sur une ligne
    -- donnée avec un highlighting donné.
    append = function(nr, data, l, hl)

        data = (type(data) == "table" and data or { data })
        vim.api.nvim_buf_set_lines(nr, l, l, true, data)

        -- si hl n'est pas null alors j'applique hl sur la
        -- ligne l donné en entrée.
        if hl then
            vim.api.nvim_buf_add_highlight(nr, -1, hl, l, 0, -1)
        end
    end,
}

-- @description permet de change la taille d'un buffer relativement
-- à son contenue et donc de sa direction (vertical, horizontal).
-- TODO: trouver une solution plus propre pour dir.
-- @param dir: les valeurs acceptées sont "s" ou "v"
local function resize_win(bufnr, dir)

    -- je ne veux utiliser cette fonction
    -- que pour resize les fenêtre de RunCode
    if vim.bo.filetype ~= "RunCode" then
        return
    end

    local size = (function()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        if dir == "s" then
            -- si horizontal alors je retourne le nombre de
            -- lignes présentes dans le buffer.
            return #lines
        else
            local m

            -- si vertical alors je retourne le longueur
            -- de la plus longue lignée présente dans le buffer.
            for _, v in ipairs(lines) do
                if not m or m < #v then
                    m = #v
                end
            end

            return m
        end
    end)()

    vim.api.nvim_command(string.format(
        "%s res %s", dir == "v" and "vert" or "", size
    ))

end

-- @description permet de savoir si un buffer RunCode est déjà
-- ouvert ou non dans la session.
-- @return le numéro du buffer RunCode si
-- trouvé ou false sinon.
local function is_open()

    local bufs = vim.func.buflst()

    for _, buf in ipairs(bufs) do
        if vim.func.buf('filetype', buf) == 'RunCode' then
            return buf
        end
    end

    return false

end

-- @description permet de clear un potentiel buffer
-- RunCode déjà existant sans le fermé pour laisser la place
-- à un nouveau output ou d'en ouvrir un nouveau dans le cas
-- contraire. La fonction retourne le bufnr du buffer clear ou ouvert.
local function prepare_buf(dir)

    local commands = {
        s = "bo new",
        v = "vnew",
        t = "tabnew"
    }

    local bufnr = is_open()

    if bufnr then
        write.clear(bufnr)
    else
        vim.api.nvim_command(
            commands[dir]
        )

        bufnr = vim.fn.bufnr()
    end

    return bufnr
end

local function run(dir)

    vim.g.target = {
        view = vim.fn.winsaveview(),
        bufnr = vim.fn.bufnr(),
        filename = vim.func.buf('filename'),
    }

    if not ls.get(vim.g.target.bufnr) then
        return
    end

    vim.func.timer_start()
    local error = false
    local output = {}

    vim.fn.jobstart(vim.fn.join(ls.get(vim.g.target.bufnr), " "), {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then table.insert(output, data) end
        end,
        on_stderr = function(_, data)
            if data then table.insert(output, data) end
        end,
        on_exit = function()

            local rc_bufnr = prepare_buf(dir)

            write.append(
                rc_bufnr,
                "In: " .. vim.func.timer_end() .. " ms | " ..
                "Lines: " .. vim.api.nvim_buf_line_count(vim.g.target.bufnr),
                0, "RunCodeInfo"
            )

            write.append(
                rc_bufnr, "=> Output of: " .. vim.g.target.filename, 2,
                "RunCode" .. (error and "Error" or "Ok")
            )

            write.append(rc_bufnr, "", -1)

            for _, data in ipairs(output) do
                write.append(rc_bufnr, data, -1)
            end

            vim.g.opts.buffer("RunCode")
            resize_win(rc_bufnr, dir)
        end
    })

end

function M.keymaps()

    vim.g.nmap("<leader>x", function()
        run("s")
    end)

    vim.g.nmap("<leader>xv", function()
        run("v")
    end)

    vim.g.nmap("<leader>xt", function()
        run("t")
    end)

end

function M.autocmds()

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "RunCode",
        callback = function()
            vim.g.nmap({ "<cr>", "q" }, function()
                vim.func.close(vim.fn.bufnr())
                vim.fn.winrestview(vim.g.target.view)
            end, { buffer = 0 })
        end
    })

    vim.api.nvim_create_autocmd("BufWinLeave", {
        pattern = "RunCode",
        callback = function()
            vim.fn.winrestview(vim.g.target.view)
        end
    })

end

return M
