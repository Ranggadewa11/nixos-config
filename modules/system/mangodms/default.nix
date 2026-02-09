{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.systemSettings.mango;
in {
  imports = [
    inputs.mango.nixosModules.mango
    inputs.dms.nixosModules.dank-material-shell
  ];
  options = {
    systemSettings.mango = {
      enable = lib.mkEnableOption "Enable mangodms";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mango.enable = true;
    programs.dank-material-shell.enable = true;
    hardware.graphics.enable = true;
    environment.systemPackages = with pkgs; [
      wl-clipboard
      cliphist
      fcitx5
      satty
      slurp
      grim
      xdg-desktop-portal-wlr
    ];
  };
}
