{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "dewtf";
  home.homeDirectory = "/home/dewtf";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  userSettings.recording.enable = true;

  imports = [
    ../../modules/users
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;
  # PAKETTT
  home.packages = with pkgs; [
    kitty
    helix
    yazi
    gemini-cli
  ];
}
