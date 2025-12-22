# Anything you want to share between hosts
{
  inputs,
  config,
  lib,
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

  boot.initrd.postResumeCommands = lib.mkAfter ''
    echo 'starting rollback'
    zfs rollback -r zroot/local/root@blank
    echo 'finished rollback'
  '';

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
      inputs.impermanence.homeManagerModules.impermanence
      ../modules/hostSpec.nix
    ];
    home.persistence."/persist/home/${mySpecs.username}" = {
      directories = [
        {
          directory = ".ssh";
          method = "symlink";
        }
        ".gnupg"
        {
          directory = ".librewolf/${mySpecs.username}/extensions"; # installed extensions
          method = "symlink";
        }
      ];
      files = [
        ".gitconfig"
      ];
      allowOther = true;
    };
    hostSpec = mySpecs; # Sets hostSpecs in home-manager context
  };

  hostSpec = mySpecs; # Sets hostSpecs in nixos context
}
