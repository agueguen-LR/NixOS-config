# Anything you want to share between hosts
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  mySpecs = {
    username = "adrien";
    keyboard = {
      layout = "fr";
      options = "eurosign:e,caps:escape";
    };
  };
in {
  imports = [
    inputs.agenix.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    ../modules/hostSpec.nix
  ];

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

  # boot.initrd.postResumeCommands = lib.mkAfter ''
  #   echo 'starting rollback'
  #   zfs rollback -r zroot/local/root@blank
  #   echo 'finished rollback'
  # '';

  age = {
    identityPaths = ["/persist/home/${mySpecs.username}/.secrets/agenix-rsa-4096"];
    secrets.user-password.file = ../secrets/user-password.age;
  };

  users.users.${mySpecs.username} = {
    # initialHashedPassword = # Set this and comment hashedPasswordFile during install
    hashedPasswordFile = config.age.secrets.user-password.path;
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  time.timeZone = "Europe/Paris";

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
  home-manager.users.${mySpecs.username} = {
    imports = [
      ../modules/hostSpec.nix
    ];
    home.persistence."/persist" = {
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
    hostSpec = mySpecs; # Sets hostSpecs in home-manager context
  };

  hostSpec = mySpecs; # Sets hostSpecs in nixos context
}
