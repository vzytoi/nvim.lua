local function init()

    local files = {
        {n = "options"},
        {n = "colors"},
        {n = "autocmd"},
        {n = "plugins"},
        {n = "abbr"}
    }

    for _, f in pairs(files) do
        if f.d ~= nil and f.d then
            goto endl
        end

        if not pcall(require, f.n) then
            print("unable to require " .. f.n)
        end

        ::endl::
    end
end

init()
