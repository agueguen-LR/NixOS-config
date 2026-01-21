{
  config,
  lib,
  pkgs,
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

  boot.kernelModules = ["cp210x"];

  networking = {
    hostName = "nixos-laptop";
    hostId = "81cd2a4d"; # Needed for ZFS
  };

  # Any unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "android-studio-stable"
    ];

  # Enable touchpad support.
  services.libinput.enable = true;

  # Power management for noctalia-shell
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  users.users.${config.hostSpec.username}.packages = with pkgs; [
    android-studio
    android-tools
    zulu17
  ];

  environment.persistence."/persist".directories = [
    "/var/lib/libvirt" # virt-manager
    "/var/lib/bluetooth"
  ];

  home-manager.users.${config.hostSpec.username}.hostSpec = {
    hasBattery = true;
    monitor = myMonitorInfo;
  };
  hostSpec = {
    hasBattery = true;
    monitor = myMonitorInfo;
  };
}
