function RI()

    local files = {
        {
            n = 'example',
            d = true
        },
        { n = 'options' },
        { n = 'autocmd' },
        { n = 'plugins' }
    }

    for _, f in pairs(files) do

        if f.d ~= nil and f.d then
            goto endl
        end

        function R() require(f.n) end

        if not pcall(R) then
            print('unable to require ' .. f.n)
        end

        ::endl::

    end

end

RI()
