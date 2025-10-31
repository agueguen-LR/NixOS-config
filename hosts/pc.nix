{
  inputs,
  config,
  lib,
  ...
}: let
  hostSpecs = {
    username = "adrien";
    monitor = {
      name = ["HDMI-A-1" "HDMI-A-2"];
      width = ["1920" "1920"];
      height = ["1080" "1080"];
      xoffset = ["0" "1920"];
      yoffset = ["0" "0"];
      refreshRate = ["60" "60"];
    };
  };
in {
  imports = [
    ../hardware/pc-hardware.nix
    ../disko/pc-disko.nix
    ../modules/hostSpec.nix
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
    hostName = "nixos-pc";
    hostId = "466b81e1"; # Needed for ZFS
  };

  # Any unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "steam"
    ];
  # nixpkgs.config.allowUnfree = true; # Allow all unfree packages :(

  home-manager.users.${hostSpecs.username}.hostSpec = hostSpecs;
  hostSpec = hostSpecs;
}
