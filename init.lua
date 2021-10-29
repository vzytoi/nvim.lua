function RI()

    local files = {
        {
            n = "example",
            d = true
        },
        {n = "options"},
        {n = "colors"},
        {n = "autocmd"},
        {n = "plugins"},
        {n = "abbreviations"}
    }

    for _, f in pairs(files) do

        if f.d ~= nil and f.d then
            goto endl;
        end

        if not pcall(require, f.n) then
            print("unable to require " .. f.n)
        end

	::endl::

    end

end

RI()
