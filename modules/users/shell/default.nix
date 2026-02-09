{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;

    # Hilangkan greeting message
    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAliases = {
      ll = "ls -lah";
      c = "clear";

      # Git
      gs = "git status";
      gaa = "git add .";
      gcm = "git commit -m";
      gp = "git push origin main";

      updatecon = "sudo nixos-rebuild switch --flake ~/.dotfiles#ax14r5";
      updatehome = "home-manager switch --flake ~/.dotfiles#dewtf";
      updatesys = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .#ax14r5 && home-manager switch --flake .#dewtf";
      bersih2 = "sudo nix-collect-garbage -d";
      cddot = "cd ~/.dotfiles";

      ditcon = "hx ~/.dotfiles/hosts/ax14r5/configuration.nix";
      ditflake = "hx ~/.dotfiles/flake.nix";
      dithome = "hx ~/.dotfiles/hosts/ax14r5/home.nix";
    };
  };
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
  home.packages = with pkgs; [
    # System Tools moved from system packages
    ripgrep
    bat
    fastfetch
    unzip
    fzf
  ];
}
