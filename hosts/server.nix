{...}: let
  hostSpecs = {
    username = "adrien";
  };
in {
  imports = [
    ../hardware/server-hardware.nix
    ../disko/server-disko.nix
  ];

  networking = {
    hostName = "nixos-server";
    hostId = "a58d9f9e"; # Needed for ZFS
  };

  home-manager.users.${hostSpecs.username}.hostSpec = hostSpecs;
  hostSpec = hostSpecs;
}
