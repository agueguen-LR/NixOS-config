# Anything you want to share between all workstations
{
  config,
  pkgs,
  root,
  lib,
  ...
}: {
  imports = [
    (root + /hosts/shared-config.nix)
  ];

  # Any unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.persistence."/persist".directories = [
    "/var/lib/systemd/"
    "/var/lib/libvirt" # virt-manager
    "/var/lib/bluetooth"
  ];

  home-manager.users.${config.hostSpec.username} = {
    home.packages = with pkgs; [
      pixi
      kdePackages.dolphin
      nautilus
      zulu25
    ];
  };
}
