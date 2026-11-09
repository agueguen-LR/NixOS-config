{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    mkHost = host: profile:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          root = self;
        };
        modules = [
          ./hosts/${host}
          ./profiles/${profile}/configuration.nix
        ];
      };
  in {
    system = "x86_64-linux";

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      server = mkHost "server" "server";
      laptop-default = mkHost "workstations/laptop" "default";
      laptop-qtile = mkHost "workstations/laptop" "qtile";
      laptop-hypr = mkHost "workstations/laptop" "hyprland";
      laptop-kde = mkHost "workstations/laptop" "kde";
      laptop-mango = mkHost "workstations/laptop" "mango";
      laptop-niri = mkHost "workstations/laptop" "niri";
      pc-default = mkHost "workstations/pc" "default";
      pc-qtile = mkHost "workstations/pc" "qtile";
      pc-hypr = mkHost "workstations/pc" "hyprland";
      pc-kde = mkHost "workstations/pc" "kde";
      pc-mango = mkHost "workstations/pc" "mango";
      pc-niri = mkHost "workstations/pc" "niri";
    };
  };
}
