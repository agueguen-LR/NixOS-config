{ inputs, outputs, ... }:
{
  imports = [ 
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
		useGlobalPkgs = true; # Use same instance of nixpkgs for nixos and hm
		extraSpecialArgs = {inherit inputs outputs;};
	};
}
