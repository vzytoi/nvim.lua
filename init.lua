function load_files()

    local files = {
        { 'options', false },
        { 'autocmd', false },
        { 'plugins', false }
    }

    for _, f in ipairs(files) do
        if not f[2] then
            require(f[1])
        end
    end

end
