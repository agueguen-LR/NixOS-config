{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      inherit (self) outputs;
    in
  {
    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./configs/default/configuration.nix
        ];
      };

      qtile = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./configs/qtile/configuration.nix
        ];
      };

      hyprland = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./configs/hyprland/configuration.nix
        ];
      };

    };
  };
}
