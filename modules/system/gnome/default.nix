{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.systemSettings.gnome;
in {
  options = {
    systemSettings.gnome = {
      enable = lib.mkEnableOption "Enable gnome";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-extension-manager
      gnome.gvfs
      gnome-shell
      gnome-tweaks
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      valent
    ];
    # Valent
    programs.kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };

    environment.gnome.excludePackages = with pkgs; [
      orca
      evince
      # file-roller
      geary
      gnome-disk-utility
      # seahorse
      # sushi
      # sysprof
      #
      # gnome-shell-extensions
      #
      # adwaita-icon-theme
      #nixos-background-info
      gnome-backgrounds
      # gnome-bluetooth
      # gnome-color-manager
      # gnome-control-center
      # gnome-shell-extensions
      gnome-tour # GNOME Shell detects the .desktop file on first log-in.
      gnome-user-docs
      # glib # for gsettings program
      # gnome-menus
      # gtk3.out # for gtk-launch program
      # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
      # xdg-user-dirs-gtk # Used to create the default bookmarks
      #i
      baobab
      epiphany
      gnome-text-editor
      gnome-characters
      # gnome-clocks
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-music
      gnome-system-monitor
      gnome-weather
      # loupe
      # nautilus
      simple-scan
      snapshot
      totem
      yelp
      gnome-software
    ];
  };
}
