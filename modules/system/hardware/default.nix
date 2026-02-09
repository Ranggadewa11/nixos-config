{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.systemSettings.hardware;
in {
  options.systemSettings.hardware = {
    enable = lib.mkEnableOption "Enable Basic Hardware Support";
    audio.enable = lib.mkEnableOption "Enable Pipewire Audio";
    graphics.enable = lib.mkEnableOption "Enable OpenGL & Drivers";
  };

  config = lib.mkIf cfg.enable {
    # --- Bootloader & Kernel ---
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = false;
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Kernel Modules (OBS Cam, dll)
    boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    boot.kernelModules = ["v4l2loopback"];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    boot.initrd.kernelModules = ["amdgpu"];

    # --- Graphics ---
    hardware.graphics = lib.mkIf cfg.graphics.enable {
      enable = true;
      enable32Bit = true;
    };
    hardware.enableRedistributableFirmware = true;

    # --- Audio ---
    services.pipewire = lib.mkIf cfg.audio.enable {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
    };

    # --- Hardware Specific Packages ---
    environment.systemPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
