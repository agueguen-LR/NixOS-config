# Anything you want to share between all hosts
{
  inputs,
  outputs,
  config,
  root,
  pkgs,
  hm,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
  ];
  config =
    {
      hostSpecs = {
        username = "adrien";
        keyboard = {
          layout = "fr";
          options = "eurosign:e,caps:escape";
        };
      };

      fileSystems."/persist".neededForBoot = true;

      boot.zfs.forceImportRoot = false;

      boot.initrd.systemd.services.rollback = {
        description = "Rollback root filesystem";

        wantedBy = [
          "initrd.target"
        ];
        after = [
          "zfs-import-zroot.service"
        ];
        before = [
          "sysroot.mount"
        ];

        path = with pkgs; [
          zfs
        ];

        serviceConfig.Type = "oneshot";
        script = ''
          echo 'starting rollback'
          zfs rollback -r zroot/local/root@blank
          echo 'finished rollback'
        '';
      };

      boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      system.autoUpgrade = {
        enable = true;
        dates = "weekly";
      };

      nix = {
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 10d";
        };
        optimise.automatic = true;
        settings.experimental-features = ["nix-command" "flakes"];
      };

      age = {
        identityPaths = ["/persist/home/${config.hostSpecs.username}/.secrets/agenix-rsa-4096"];
        secrets.user-password.file = ../secrets/user-password.age;
      };

      users = {
        mutableUsers = false;
        users.${config.hostSpecs.username} = {
          # initialHashedPassword = # Set this and comment hashedPasswordFile during install
          hashedPasswordFile = config.age.secrets.user-password.path;
          isNormalUser = true;
          extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
        };
      };

      nix.settings.trusted-users = ["root" "@wheel"];

      networking.networkmanager.enable = true;

      i18n.defaultLocale = "en_GB.UTF-8";

      time.timeZone = "Europe/Paris";

      console = {
        keyMap = config.hostSpecs.keyboard.layout;
        font = "Lat2-Terminus16";
      };

      services.openssh.enable = true;

      environment.systemPackages = [
        pkgs.vim
        pkgs.git
      ];

      programs = {
        fuse.userAllowOther = true; # see https://github.com/nix-community/impermanence#home-manager
        nix-ld.enable = true;
      };

      # impermanence module settings
      environment.persistence."/persist" = {
        directories = [
          "/var/lib/nixos" #see https://github.com/nix-community/impermanence/issues/178
          "/etc/NetworkManager/system-connections"
        ];
        files = [
          "/etc/machine-id" # networking.hostId first 8 chars
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
        ];
      };

      home-manager = {
        useGlobalPkgs = true; # Use same instance of nixpkgs for nixos and hm
        extraSpecialArgs = {inherit inputs outputs;};
      };
    }
    // hm config {
      home = {
        username = config.hostSpecs.username;
        homeDirectory = "/home/${config.hostSpecs.username}";

        persistence."/persist" = {
          directories = [
            {
              directory = ".ssh";
            }
            ".gnupg"
          ];
          files = [
            ".gitconfig"
          ];
        };
      };

      programs = {
        gpg.enable = true;
        home-manager.enable = true; # Let Home Manager install and manage itself.
      };
    };
}
