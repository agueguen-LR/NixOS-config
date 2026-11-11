{
  root,
  config,
  pkgs,
  lib,
  inputs,
  hm,
  ...
}: {
  imports = [
    (root + /hardware/pc-hardware.nix)
    (root + /disko/pc-disko.nix)
    (root + /hosts/workstations/shared-config.nix)
  ];

  config =
    {
      hostSpecs.monitor = {
        name = ["HDMI-A-1" "HDMI-A-2"];
        width = [1920 1920];
        height = [1080 1080];
        xoffset = [0 1920];
        yoffset = [0 0];
        refreshRate = [60.0 60.0];
      };

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

      features = {
        steam.enable = true;
        postgresql.enable = true;
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
        persistence."/persist".directories = [
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

        packages = with pkgs; [
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
      };
    };
}
