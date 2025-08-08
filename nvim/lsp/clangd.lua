return {
    cmd = {
        "clangd",
        "--query-driver=/home/linuxbrew/.linuxbrew/bin/g++-15",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--all-scopes-completion",
        "--suggest-missing-includes",
        "--cross-file-rename",
        "--log=info",
    },
    filetypes = { "c", "cpp", "cuda", "objc", "objcpp", "proto" },
    root_markers = {
        "CMakeLists.txt",
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
    },
    settings = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
    }
}