function RI()

    local files = {
        { 'example', false},
        { 'options' },
        { 'autocmd' },
        { 'plugins' }
    }

    for _, f in pairs(files) do

        if f[2] ~= nil and not f[2] then
            goto endl
        end

        function T() require(f[1]) end

        if not pcall(T) then
            print('error loading ' .. f[1])
        end

        ::endl::

    end

end

RI()
