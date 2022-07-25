return {
    typescript = "ts-node #",
    javascript = { "node", "#" },
    c = "gcc # -o @.exe && ./@.exe",
    go = "go run #",
    java = "javac #;java @",
    cpp = "g++ -o @.exe # && ./@.exe",
    ps1 = "powershell ./#",
    rust = "if cargo verify-project > /dev/null 2>&1; cargo run; else; rustc # && ./@; end;",
    php = "php #",
    python = "python3 #",
    lua = { "lua", "#" }
}
