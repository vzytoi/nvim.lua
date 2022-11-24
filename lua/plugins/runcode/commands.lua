local FT = {}

local buildpath = function(name)
    return vim.fn.stdpath('data') .. "/runcode/" .. name
end

local get_projects = function(ft)
    return ({
        ocaml = { 'dune-workspace', 'dune-project' }
    })[ft]
end

local is_in_project = function(args)

    local files = get_projects(args.filetype)

    for _, v in ipairs(files) do
        if #vim.fs.find(v, { upward = true }) > 0 then
            return true
        end
    end

    return false
end

FT.get_lst = function(args)
    local lst = {
        typescript = { "ts-node", args.filepath },
        javascript = { "node", args.filepath },
        go = { "go", "run", args.filepath },
        php = { "php", args.filepath },
        python = { "python3", args.filepath },
        lua = { "lua", args.filepath },
        swift = { "swift", args.filepath },
        ocaml = { "ocaml", args.filepath },
        c = { "gcc", args.filepath, "-o", buildpath(args.filetag), "&&", buildpath(args.filetag) }
    }

    return lst[args.filetype]
end


FT.get = function(bufnr)

    return FT.get_lst({
        filepath = u.fun.buf('filepath', bufnr),
        filetype = u.fun.buf('filetype', bufnr),
        filetag = u.fun.buf('filetag', bufnr)
    }) or false

end

FT.get(vim.fn.bufnr())

return FT
