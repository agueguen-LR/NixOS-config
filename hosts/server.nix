{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../hardware/server-hardware.nix
    ../disko/server-disko.nix
  ];

  networking = {
    hostName = "nixos-server";
    hostId = "a58d9f9e"; # Needed for ZFS
  };
}
