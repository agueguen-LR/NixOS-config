{
  root,
  config,
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
    (root + /hardware/laptop-hardware.nix)
    (root + /disko/laptop-disko.nix)
    (root + /hosts/workstations/shared-config.nix)
  ];

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

  home-manager.users.${config.hostSpec.username}.hostSpec = {
    hasBattery = true;
    monitor = myMonitorInfo;
  };
  hostSpec = {
    hasBattery = true;
    monitor = myMonitorInfo;
  };
}
