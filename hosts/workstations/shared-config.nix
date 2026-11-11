# Anything you want to share between all workstations
{
  config,
  pkgs,
  root,
  lib,
  hm,
  ...
}: {
  imports = [
    (root + /hosts/shared-config.nix)
  ];

  config =
    {
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

      fonts.packages = with pkgs.nerd-fonts; [
        jetbrains-mono
      ];

      # enabling modules from root/modules
      features = {
        catppuccin.enable = true;
        dms.enable = true;
        direnv.enable = true;
        fish.enable = true;
        fzf.enable = true;
        kitty.enable = true;
        librewolf.enable = true;
        niri = {
          enable = true;
          runOnLaunch = [
            ["dms" "run" "-d"]
          ];
        };
        nixvim.enable = true;
        yazi.enable = true;
        vesktop.enable = true;
        virt-manager.enable = true;
        zoxide.enable = true;
      };

      hostSpecs.keybinds = {
        browser = "Mod+B";
        terminal = "Mod+T";
        screenshot = "Print";
        appLauncher = "Mod+R";
        settings = "Mod+S";
        restartQuickshell = "Mod+Shift+R";
      };

      # Fix pixi failing to build in current nixpkgs
      nixpkgs.overlays = [
        (final: prev: {
          pixi = prev.pixi.overrideAttrs (old: {
            nativeBuildInputs =
              (old.nativeBuildInputs or [])
              ++ [
                final.pkg-config
              ];

            buildInputs =
              (old.buildInputs or [])
              ++ [
                final.zstd
              ];

            preBuild =
              (old.preBuild or "")
              + ''
                export AWS_LC_SYS_USE_SYSTEM=0
              '';
          });
        })
      ];
    }
    // hm config {
      home.packages = with pkgs; [
        btop
        fastfetch
        kdePackages.dolphin
        nautilus
        pavucontrol #volume control
        pixi
        sysstat #system info commands: iostat mpstat pidstat ...
        wl-clipboard
        zulu25
      ];

      home.sessionVariables = {
        DISPLAY = ":0";
      };

      services.gpg-agent = {
        enable = true;
        enableFishIntegration = true;
        extraConfig = ''
          allow-loopback-pinentry
        '';
        pinentry = {
          package = pkgs.pinentry-rofi;
          program = "pinentry-rofi";
        };
      };
    };
}
