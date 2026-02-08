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

  xdg.configFile."systemd/user/mango-session-target".source = ../../modules/users/mango-conf/mango-session-target;
  xdg.configFile."mango".source = ../../modules/users/mango-conf;
  xdg.configFile."helix".source = ../../modules/users/helix-conf;
  xdg.configFile."kitty".source = ../../modules/users/kitty-conf;

  imports = [
    ../../modules/users/shell/default.nix
    ../../modules/users/bahasa/default.nix
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
