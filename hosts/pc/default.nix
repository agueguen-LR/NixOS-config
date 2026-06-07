{
  config,
  pkgs,
  lib,
  outputs,
  inputs,
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
    outputs.nixosModules.steam
    outputs.nixosModules.postgresql
  ];

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
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  users.users.${config.hostSpec.username}.packages = with pkgs; [
    heroic-unwrapped
    umu-launcher
    zulu25 # java

    inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system}.ninjabrain-bot
    prismlauncher
    xwayland
    kdePackages.dolphin
    nautilus
  ];

  environment.persistence."/persist".directories = [
    "/var/lib/systemd/"
    "/var/lib/libvirt" # virt-manager
    "/var/lib/bluetooth"
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  home-manager.users.${config.hostSpec.username} = {
    home.persistence."/persist".directories = [
      {
        directory = ".local/share/soh"; #Ship of harkinian
      }
      {
        directory = ".local/share/Steam";
      }
      {
        directory = ".java/.userPrefs/ninjabrainbot";
      }
      {
        directory = ".config/waywall";
      }
      {
        directory = ".local/share/flatpak/app/com.hypixel.HytaleLauncher";
      }
      {
        directory = ".var/app/com.hypixel.HytaleLauncher";
      }
      {
        directory = ".local/share/PrismLauncher";
      }
      {
        directory = ".local/share/TwilitRealm";
      }
      {
        directory = ".local/share/osu";
      }
      {
        directory = ".config/heroic";
      }
      {
        directory = "Games/Heroic";
      }
      {
        directory = "Games/umu";
      }
    ];
    hostSpec.monitor = myMonitorInfo;
  };

  hostSpec.monitor = myMonitorInfo;
}
