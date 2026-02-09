{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.systemSettings.security;
in {
  options.systemSettings.security = {
    enable = lib.mkEnableOption "Enable Base Security & Networking";
  };

  config = lib.mkIf cfg.enable {
    # Networking
    networking.hostName = "ax14r5";
    networking.networkmanager.enable = true;

    # Security
    security.polkit.enable = true;

    # Fish & AppImage
    programs.fish.enable = true;
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # System Packages Dasar
    environment.systemPackages = with pkgs; [
      git
      curl
      wget
      vim
      home-manager
      btop
    ];

    # Services Tambahan
    services.flatpak.enable = true;
    services.tuned.enable = true;

    # Nix Settings
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
  };
}
