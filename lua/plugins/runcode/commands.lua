local FT = {}

local read_commands = function()
    local path = vim.fn.stdpath('config') .. "/lua/plugins/runcode/commands.json"
    local cmds = vim.fn.json_decode(vim.fn.readfile(path))

    return cmds
end

FT.cmds = read_commands()

local parse_command = function(cmd, name)

    local parsing_table = {
        ["%"] = vim.fn.expand('%:p'),
        ["$"] = vim.fn.stdpath('data') .. "/runcode/" .. vim.fn.expand('%:t:r'),
        ["^"] = name or ""
    }

    for sub, rep in pairs(parsing_table) do
        cmd = string.gsub(cmd, "%" .. sub, rep)
    end

    return vim.fn.split(cmd, "")
end


local look_for_project = function(ft)

    if ft == "ocaml" then

        local names = {
            "dune-workspace", "dune-project"
        }

        for _, v in ipairs(names) do
            if #vim.fs.find(v, { upward = true }) > 0 then
                return true
            end
        end

        return false

    end

end

local get_project_name = function(ft)
    if ft == "ocaml" then
        local grep = vim.split(
            vim.fn.system("grep public_name **/dune")
            , " ")

        local i = -1

        for k, v in ipairs(grep) do
            if string.find(v, 'public_name') then
                i = k + 1
            end
        end

        local name = grep[i]:gsub('%)', '')

        return name
    end
end

FT.get = function(bufnr)

    local ft = vim.fn.getbufvar(bufnr, "&filetype")
    local cmd = FT.cmds[ft]

    if not cmd then
        return nil
    end

    if type(cmd) == "table" then
        if look_for_project(ft) then
            local name = get_project_name(ft)

            return parse_command(cmd.project, name)
        end

        return parse_command(cmd.default)
    end

    return parse_command(cmd)
end

return FT
