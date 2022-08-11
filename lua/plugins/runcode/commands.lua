local FT = {}

FT.get_lst = function(args)
    local lst = {
        typescript = { "ts-node", args.filepath },
        javascript = { "node", args.filepath },
        go = { "go", "run", args.filepath },
        php = { "php", args.filepath },
        python = { "python3", args.filepath },
        lua = { "lua", args.filepath },
        swift = { "swift", args.filepath }
    }

    return lst[args.filetype]
end

FT.get = function(bufnr)

    return FT.get_lst(vim.func.buf(bufnr))
        or false

end

return FT
