u = setmetatable({}, {
    __index = function(t, i)
        local f = require('utils.' .. i)

        if f then
            rawset(t, i, f)
        end

        return f
    end
})

nvim = setmetatable({}, {

    __index = function(t, i)
        local f = vim.api['nvim_' .. i]

        if f then
            rawset(t, i, f)
        end

        return f
    end

})

P = function(obj)
    print(vim.inspect(obj))
    return obj
end
