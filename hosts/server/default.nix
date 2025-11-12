{...}: {
  imports = [
    ../../hardware/server-hardware.nix
    ../../disko/server-disko.nix
    ../shared-config.nix
  ];

  boot.initrd.postDeviceCommands = ''
    echo 'starting rollback'
      zpool import zroot
      zfs rollback -r zroot/local/root@blank
    echo 'finished rollback'
  '';

  networking = {
    hostName = "nixos-server";
    hostId = "a58d9f9e"; # Needed for ZFS
  };
}
