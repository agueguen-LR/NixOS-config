{
  config,
  lib,
  ...
}: let
  myMonitorInfo = {
    name = ["eDP-1" "HDMI-A-2"];
    width = [1920 1920];
    height = [1080 1080];
    xoffset = [0 1920];
    yoffset = [0 0];
    refreshRate = [60.0 60.0];
  };
in {
  imports = [
    ../../hardware/laptop-hardware.nix
    ../../disko/laptop-disko.nix
    ../shared-config.nix
  ];

  boot.initrd.postDeviceCommands = ''
    echo 'starting rollback'
      zpool import zroot
      zfs rollback -r zroot/local/root@blank
    echo 'finished rollback'
  '';

  networking = {
    hostName = "nixos-laptop";
    hostId = "81cd2a4d"; # Needed for ZFS
  };

  # Any unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  # Enable touchpad support.
  services.libinput.enable = true;

  # Power management for noctalia-shell
  services.power-profiles-daemon.enable = true;

  home-manager.users.${config.hostSpec.username}.hostSpec = {
    hasBattery = true;
    monitor = myMonitorInfo;
  };
  hostSpec = {
    monitor = myMonitorInfo;
    hasBattery = true;
  };
}
