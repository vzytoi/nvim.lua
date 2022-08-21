local FT = {}

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
        c = { "gcc", "-o", args.filetag, args.filepath, "&&", "./" .. args.filetag },
        cpp = { "g++", args.filepath, "-o", args.filetag, "&&", "./" .. args.filetag }
    }

    return lst[args.filetype]
end

FT.get = function(bufnr)

    return FT.get_lst({
        filepath = vim.fun.buf('filepath', bufnr),
        filetype = vim.fun.buf('filetype', bufnr),
        filetag = vim.fun.buf('filetag', bufnr)
    }) or false

end

return FT
