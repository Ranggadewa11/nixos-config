{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Import modul NixOS langsung dari input flake
    inputs.mango.nixosModules.mango
    inputs.dms.nixosModules.dank-material-shell
  ];

  # Aktifkan service-nya (bukan home.packages lagi)
  programs.mango = {
    enable = true;
    # settings = { ... }; # Jika ada settingan sistem
  };

  programs.dms-shell = {
    enable = true;
    # settings = { ... };
  };

  # Opsional: Pastikan OpenGL/EGL support aktif di level sistem
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    fcitx5
    satty
    slurp
    grim
    dms-shell
    quickshell
    dgop
  ];
}
