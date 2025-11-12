{
  config,
  lib,
  ...
}: let
  myMonitorInfo = {
    name = ["HDMI-A-1" "HDMI-A-2"];
    width = [1920 1920];
    height = [1080 1080];
    xoffset = [0 1920];
    yoffset = [0 0];
    refreshRate = [60.0 60.0];
  };
in {
  imports = [
    ../../hardware/pc-hardware.nix
    ../../disko/pc-disko.nix
    ../shared-config.nix
  ];

  specialisation.rollback.configuration = {
    boot.initrd.postDeviceCommands = ''
      echo 'starting rollback'
        zpool import zroot
        zfs rollback -r zroot/local/root@blank
      echo 'finished rollback'
    '';
  };

  boot.loader.systemd-boot.extraEntries."Windows11.conf" = ''
    title Windows 11
    efi /EFI/Microsoft/Boot/bootmgfw.efi
  '';

  networking = {
    hostName = "nixos-pc";
    hostId = "466b81e1"; # Needed for ZFS
  };

  # Any unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "steam"
    ];

  home-manager.users.${config.hostSpec.username} = {
    home.persistence."/persist/home/${config.hostSpec.username}".directories = [
      {
        directory = ".local/share/soh"; #Ship of harkinian
        method = "symlink";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".local/share/PrismLauncher";
        method = "symlink";
      }
    ];
    hostSpec.monitor = myMonitorInfo;
  };

  hostSpec.monitor = myMonitorInfo;
}
