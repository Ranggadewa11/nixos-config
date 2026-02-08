{pkgs, ...}: {
  home.packages = with pkgs; [
    # --- Dev: Go ---
    go
    gopls
    gosimports

    # --- Dev: Web ---
    nodejs
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted

    # --- Dev: Python ---
    (python3.withPackages (ps:
      with ps; [
        pandas
        numpy
        matplotlib
        seaborn
        ipython
        ruff
        black
        python-lsp-server
      ]))

    # --- Dev: Rust & C ---
    rustc
    cargo
    rust-analyzer
    clang-tools

    # --- Nix ---
    nixd
    alejandra

    # --- Misc (Docs & AI) ---
    typst
    typst-live
    tinymist
  ];
}
