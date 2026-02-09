{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.mango.nixosModules.mango
    inputs.dms.nixosModules.dank-material-shell
  ];

  # Aktifkan service-nya (bukan home.packages lagi)
  programs.mango.enable = true;
  programs.dank-material-shell = true;
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    fcitx5
    satty
    slurp
    grim
  ];
}
