{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  config = {
    systemSettings = {
      user.dewtf.enable = true;
      security.enable = true;

      hardware = {
        enable = true;
        audio.enable = true;
        graphics.enable = true;
      };

      gnome.enable = true;
      mango.enable = true;
      stylix.enable = true;
    };

    # services.displayManager.gdm.enable = true;
    services.displayManager.ly.enable = true;
    # Punten PAKET
    environment.systemPackages = with pkgs; [
      android-tools
      pear-desktop
      v4l-utils
      scrcpy
      qtscrcpy
    ];

    system.stateVersion = "25.11";
  };
}
