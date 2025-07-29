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

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      inherit (self) outputs;
			mkHost = hostFile: profileFile: nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [
					./hosts/${hostFile}
					./profiles/${profileFile}
				];
			};
    in
  {
		system = "x86_64-linux";
      
    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      server-default = mkHost "server.nix" "default/configuration.nix";
      server-qtile = mkHost "server.nix" "qtile/configuration.nix";
      server-hypr = mkHost "server.nix" "hyprland/configuration.nix";
      server-kde = mkHost "server.nix" "kde/configuration.nix";
    };
  };
}
