local FT = {}


local check_project = function(ft)
    local names = ({
        ocaml = { 'dune-workspace', 'dune-project' }
    })[ft]

    for _, v in ipairs(names) do
        if #vim.fs.find(v, { upward = true }) > 0 then
            return true
        end
    end

    return false
end

FT.get_lst = function(args)
    local lst = {
        typescript = function() return { "ts-node", args.filepath } end,
        javascript = function() return { "node", args.filepath } end,
        go = function() return { "go", "run", args.filepath } end,
        php = function() return { "php", args.filepath } end,
        python = function() return { "python3", args.filepath } end,
        lua = function() return { "lua", args.filepath } end,
        swift = function() return { "swift", args.filepath } end,
        ocaml = function()
            if not check_project(args.filetype) then
                return { "ocaml", args.filepath }
            else
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
                return { "dune exec", name }
            end
        end,
        c = function()
            local bd = vim.fn.stdpath('data') .. "/runcode/" .. args.filetag
            return { "gcc", args.filepath, "-o", bd, "&&", bd }
        end
    }

    return lst[args.filetype]
end


FT.get = function(bufnr)

    return FT.get_lst({
        filepath = u.fun.buf('filepath', bufnr),
        filetype = u.fun.buf('filetype', bufnr),
        filetag = u.fun.buf('filetag', bufnr)
    })() or false

end

return FT
