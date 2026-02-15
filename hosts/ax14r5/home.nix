{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.username = "dewtf";
  home.homeDirectory = "/home/dewtf";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  userSettings = {
    recording.enable = true;
    office.enable = true;
  };

  imports = [
    ../../modules/users
    inputs.zen-browser.homeModules.beta
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/landscapes/evening-sky.png";
      sha256 = "sha256-ZYA0yj704yzbNy+o2Kf+XZliKd4uzUbScW0pMw4/aE0=";
    };
    targets.zen-browser.enable = false;
  };

  programs.zen-browser.enable = true;
  # PAKETTT
  home.packages = with pkgs; [
    kitty
    helix
    yazi
    gemini-cli
  ];
}
