{
  inputs,
  config,
  lib,
  ...
}: let
  hostSpecs = {
    username = "adrien";
    keyboard = {
      layout = "fr";
      options = "eurosign:e,caps:escape";
    };
  };
in {
  imports = [
    ../hardware/server-hardware.nix
    ../disko/server-disko.nix
    inputs.agenix.nixosModules.default # secret management
  ];

  age = {
    identityPaths = ["/persist/home/${hostSpecs.username}/.secrets/agenix-rsa-4096"];
    secrets.user-password.file = ../secrets/user-password.age;
  };

  fileSystems."/persist".neededForBoot = true;

  boot.initrd.postDeviceCommands = ''
    echo 'starting rollback'
      zpool import zroot
      zfs rollback -r zroot/local/root@blank
    echo 'finished rollback'
  '';

  users.users.${hostSpecs.username} = {
    # initialHashedPassword = # Set this and comment hashedPasswordFile during install
    hashedPasswordFile = config.age.secrets.user-password.path;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr";

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  networking = {
    hostName = "nixos-server";
    hostId = "a58d9f9e"; # Needed for ZFS
  };

  home-manager.users.${hostSpecs.username}.hostSpec = hostSpecs;
  hostSpec = hostSpecs;
}
