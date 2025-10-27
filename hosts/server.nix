{inputs, config, lib, ...}: let
  hostSpecs = {
    username = "adrien";
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
