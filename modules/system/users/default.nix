{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.systemSettings.user;
in {
  options.systemSettings.user = {
    dewtf.enable = lib.mkEnableOption "Enable User dewtf";
  };

  config = lib.mkIf cfg.dewtf.enable {
    # Time & Locale
    time.timeZone = "Asia/Jakarta";
    i18n.defaultLocale = "en_US.UTF-8";

    # User Configuration
    users.users.dewtf = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "input"
        "networkmanager"
      ];
    };

    # Fonts
    fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];
    fonts.fontconfig.defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
  };
}
