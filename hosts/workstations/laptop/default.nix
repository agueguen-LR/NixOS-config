{
  config,
  root,
  hm,
  ...
}: {
  imports = [
    (root + /hardware/laptop-hardware.nix)
    (root + /disko/laptop-disko.nix)
    (root + /hosts/workstations/shared-config.nix)
  ];

  config =
    {
      hostSpecs = {
        hasBattery = true;
        monitor = {
          name = ["eDP-1" "HDMI-A-2"];
          width = [1920 1920];
          height = [1080 1080];
          xoffset = [0 1920];
          yoffset = [0 0];
          refreshRate = [60.0 60.0];
        };
      };

      boot.kernelModules = ["cp210x"];

      networking = {
        hostName = "nixos-laptop";
        hostId = "81cd2a4d"; # Needed for ZFS
      };

      # Enable touchpad support.
      services.libinput.enable = true;

      # Power management
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;

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
      home.stateVersion = "25.05";
    };
}
