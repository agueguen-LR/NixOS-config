{...}: {
  imports = [
    ../../hardware/server-hardware.nix
    ../../disko/server-disko.nix
    ../shared-config.nix
  ];

  networking = {
    hostName = "nixos-server";
    hostId = "a58d9f9e"; # Needed for ZFS
  };
}
