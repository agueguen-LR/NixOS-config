{
  root,
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
    (root + /hardware/pc-hardware.nix)
    (root + /disko/pc-disko.nix)
    (root + /hosts/workstations/shared-config.nix)
    outputs.nixosModules.steam
    outputs.nixosModules.postgresql
  ];

  networking = {
    hostName = "nixos-pc";
    hostId = "466b81e1"; # Needed for ZFS
  };

  # Any unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  users.users.${config.hostSpec.username}.packages = with pkgs; [
    heroic-unwrapped
    umu-launcher

    inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system}.ninjabrain-bot
    prismlauncher
    waywall

    xwayland

    #emulators
    cemu
    eden

    archipelago
  ];

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
        directory = ".local/share/Cemu";
      }
      {
        directory = ".local/share/eden";
      }
      {
        directory = ".local/share/Archipelago";
      }
      {
        directory = ".local/share/Cogfly";
      }
      {
        directory = ".config/unity3d/Team Cherry";
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
      {
        directory = ".factorio";
      }
    ];
    hostSpec.monitor = myMonitorInfo;
  };

  hostSpec.monitor = myMonitorInfo;
}
