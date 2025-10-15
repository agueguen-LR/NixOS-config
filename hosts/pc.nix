{...}: {
  imports = [
    ../hardware/pc-hardware.nix
    ../disko/pc-disko.nix
  ];

  networking = {
    hostName = "nixos-pc";
    hostId = "466b81e1"; # Needed for ZFS
  };
}
