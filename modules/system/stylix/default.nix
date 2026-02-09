{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  # Shortcut ke settingan kita
  cfg = config.systemSettings.stylix;

  # 1. Lokasi folder themes
  # PENTING: Jangan lupa titik koma (;) di akhir baris ini!
  themesPath = ../../themes;

  # 2. Import tema langsung (Logic disederhanakan)
  # Kita gabungkan path dan string menggunakan interpolasi "${}"
  theme = import (themesPath + "/${cfg.theme}/default.nix");
in {
  # --- OPTIONS (TOMBOL) ---
  options.systemSettings.stylix = {
    enable = lib.mkEnableOption "Enable stylix theming";

    theme = lib.mkOption {
      default = "catppuccin-mocha";
      description = "Pilih nama folder tema yang ada di modules/themes";
      # Validasi otomatis baca folder
      type = lib.types.enum (builtins.attrNames (builtins.readDir themesPath));
    };
  };

  # --- CONFIG (MESIN) ---
  imports = [inputs.stylix.nixosModules.stylix];

  config = lib.mkIf cfg.enable {
    # Aktifkan Stylix
    stylix.enable = true;
    stylix.autoEnable = true;

    # Ambil data dari file theme
    stylix.polarity = theme.polarity;

    stylix.image = pkgs.fetchurl {
      url = theme.backgroundUrl;
      sha256 = theme.backgroundSha256;
    };

    # Mapping warna
    stylix.base16Scheme = {
      base00 = theme.base00;
      base01 = theme.base01;
      base02 = theme.base02;
      base03 = theme.base03;
      base04 = theme.base04;
      base05 = theme.base05;
      base06 = theme.base06;
      base07 = theme.base07;
      base08 = theme.base08;
      base09 = theme.base09;
      base0A = theme.base0A;
      base0B = theme.base0B;
      base0C = theme.base0C;
      base0D = theme.base0D;
      base0E = theme.base0E;
      base0F = theme.base0F;
    };

    # Fonts (JetBrains Mono)
    stylix.fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      serif = {
        name = "DejaVu Serif";
        package = pkgs.dejavu_fonts;
      };
      sansSerif = {
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
    };

    stylix.targets.console.enable = true;
    stylix.targets.chromium.enable = true;
  };
}
