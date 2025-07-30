{ inputs, outputs, ... }:
{
	imports = [
		../hardware/server-hardware.nix
		../disko/server-disko.nix
	];

	networking = {
		hostName = "nixos-server";
    hostId = "7fdbbd2"; # Needed for ZFS
	};

  environment.variables = {
    IS_LAPTOP = "false";
  };

}
