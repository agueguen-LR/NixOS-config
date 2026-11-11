{
  config,
  root,
  hm,
  ...
}: {
  imports = [
    (root + /hardware/server-hardware.nix)
    (root + /disko/server-disko.nix)
    (root + /hosts/shared-config.nix)
  ];

  config =
    {
      networking = {
        hostName = "nixos-server";
        hostId = "a58d9f9e"; # Needed for ZFS
      };

      # This option defines the first version of NixOS you have installed on this particular machine,
      # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
      #
      # Most users should NEVER change this value after the initial install, for any reason,
      # even if you've upgraded your system to a new NixOS release.
      #
      # This value being lower than the current NixOS release does NOT mean your system is
      # out of date, out of support, or vulnerable.
      system.stateVersion = "25.05";
    }
    // hm config {
      home = {
        stateVersion = "25.05";
      };
    };
}
