{ ... }:
{
	imports = [
		../hardware/laptop-hardware.nix
		../disko/laptop-disko.nix
	];

	networking = {
		hostName = "nixos-laptop";
    hostId = "81cd2a4d"; # Needed for ZFS
	};
}
