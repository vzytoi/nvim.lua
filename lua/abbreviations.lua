local abbreviations = {
    wrap = 'set wrap',
    nowrap = 'set nowrap',
    X = 'x',
    Q = 'q'
}

for l, r in pairs(abbreviations) do
    vim.cmd(string.format('cnoreabbrev %s %s', l, r))
end
