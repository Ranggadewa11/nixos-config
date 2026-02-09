{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.userSettings.office;
in {
  options = {
    userSettings.office = {
      enable = lib.mkEnableOption "Enable office";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
      zotero
      jre
      discord
      zathura
      foliate
      xournalpp
    ];
  };
}
