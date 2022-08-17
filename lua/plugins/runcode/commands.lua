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
        c = { "gcc", "-o", args.filetag, args.filepath, "&&", "./" .. args.filetag }
    }

    print(vim.fn.join(lst[args.filetype], " "))
    return lst[args.filetype]
end

FT.get = function(bufnr)

    return FT.get_lst({
        filepath = vim.func.buf('filepath', bufnr),
        filetype = vim.func.buf('filetype', bufnr),
        filetag = vim.func.buf('filetag', bufnr)
    }) or false

end

return FT
