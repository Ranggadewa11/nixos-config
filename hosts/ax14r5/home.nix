{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "dewtf";
  home.homeDirectory = "/home/dewtf";
  home.stateVersion = "26.05"; # Sesuaikan versi

  programs.home-manager.enable = true;

  imports = [
    ../../modules/users
  ];

  # PAKETTT
  home.packages = with pkgs; [
    valent

    # Desktop Apps
    kitty
    libreoffice
    jre_minimal
    zotero
    discord
    inputs.zen-browser.packages."${system}".default

    # Editors
    helix
    yazi

    #etc
    gemini-cli
  ];
}
