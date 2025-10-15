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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    mkHost = hostFile: profileFile:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/${hostFile}
          ./profiles/${profileFile}
        ];
      };
  in {
    system = "x86_64-linux";

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      server = mkHost "server.nix" "server/configuration.nix";
      laptop-default = mkHost "laptop.nix" "default/configuration.nix";
      laptop-qtile = mkHost "laptop.nix" "qtile/configuration.nix";
      laptop-hypr = mkHost "laptop.nix" "hyprland/configuration.nix";
      laptop-kde = mkHost "laptop.nix" "kde/configuration.nix";
      pc-default = mkHost "pc.nix" "default/configuration.nix";
      pc-qtile = mkHost "pc.nix" "qtile/configuration.nix";
      pc-hypr = mkHost "pc.nix" "hyprland/configuration.nix";
      pc-kde = mkHost "pc.nix" "kde/configuration.nix";
    };
  };
}
