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

    mkHost = host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          root = self;

          # Shorthand to write homeManager config from same context as NixOS config
          # Writes as: config = {<nixos options>} // hm config {<home manager options>}
          hm = localConfig: cfg: {
            home-manager.users.${localConfig.hostSpecs.username} = cfg;
          };

          # Shorthand to write modules that contain both NixOS and homeManager config
          # This function returns an entire module, so you can write modules as:
          # {mkFeature, config, ...}:
          # mkFeature config {
          #   name = <module_name>;
          #   nixosImports = <imports in nixos context>;
          #   hmImports = <imports in home-manager context>;
          #		options = <define additional options>;
          #	  nixos = {<NixOS config>};
          #   home = {<homeManager config>};
          # };
          # You can then enable the feature with features.<name>.enable = true;
          mkFeature = moduleConfig: {
            name,
            nixosImports ? [],
            hmImports ? [],
            options ? {},
            nixos ? {},
            home ? {},
          }: {
            imports = nixosImports;

            options.features.${name} =
              {
                enable = nixpkgs.lib.mkEnableOption name;
              }
              // options;

            config = nixpkgs.lib.mkIf moduleConfig.features.${name}.enable (
              nixpkgs.lib.mkMerge [
                nixos
                {
                  home-manager.users.${moduleConfig.hostSpecs.username} = {
                    imports = hmImports;
                    config = home;
                  };
                }
              ]
            );
          };
        };
        modules = [
          ./options.nix
          ./hosts/${host}
          ./modules
        ];
      };
  in {
    system = "x86_64-linux";

    nixosConfigurations = {
      server = mkHost "servers";
      laptop = mkHost "workstations/laptop";
      pc = mkHost "workstations/pc";
    };
  };
}
