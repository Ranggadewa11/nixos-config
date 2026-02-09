{
  description = "Flako dewtf";

  inputs = {
    # --- Main ---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # --- System Modules ---
    mango.url = "github:DreamMaoMao/mango";
    mango.inputs.nixpkgs.follows = "nixpkgs";
    dms.url = "github:AvengeMedia/DankMaterialShell";
    dms.inputs.nixpkgs.follows = "nixpkgs";
    dgop.url = "github:AvengeMedia/dgop";
    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    # --- User/Home Modules ---
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-monitor.url = "github:antonjah/nix-monitor";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    dms,
    dgop,
    mango,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.ax14r5 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/ax14r5/configuration.nix
        ./modules/system
      ];
    };
    homeConfigurations."dewtf" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs;
        inherit pkgs-stable;
      };
      modules = [
        ./hosts/ax14r5/home.nix
      ];
    };
  };
}
