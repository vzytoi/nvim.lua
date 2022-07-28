return {
    typescript = { "ts-node", "#" },
    javascript = { "node", "#" },
    go = { "go", "run", "#" },
    php = { "php", "#" },
    python = { "python3", "#" },
    lua = { "lua", "#" },
    java = "javac #;java @",
    c = "gcc # -o @.exe && ./@.exe",
    cpp = "g++ -o @.exe # && ./@.exe",
    ps1 = "powershell ./#",
    rust = "if cargo verify-project > /dev/null 2>&1; cargo run; else; rustc # && ./@; end;",
}
