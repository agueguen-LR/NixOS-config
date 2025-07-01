# This contains everything that's shared across configurations

{ inputs, outputs, config, pkgs, ... }:
{
  imports =
    [ 
      inputs.disko.nixosModules.disko
      ../disko/impermanence.nix
      inputs.impermanence.nixosModules.impermanence
      ./persistence.nix
      inputs.agenix.nixosModules.default # secret management
      outputs.nixosModules.home-manager
    ];

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;

  fileSystems."/persist".neededForBoot = true;

  boot.initrd.postDeviceCommands = ''
    zpool import zroot
    zfs rollback -r zroot/local/root@blank 
  '';

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    hostId = "81cd2a4d"; # Needed for ZFS
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  age = {
    identityPaths = [ "/persist/adrien/.secrets/agenix-rsa-4096" ];
    secrets.user-password.file = ../secrets/user-password.age;
  };

  users.mutableUsers = false;

  users.users.adrien = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    #initialHashedPassword = ""; # Set this and comment hashedPasswordFile during install
    hashedPasswordFile = config.age.secrets.user-password.path;
  };

  programs.fuse.userAllowOther = true; # see https://github.com/nix-community/impermanence#home-manager

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    inputs.home-manager.packages.${outputs.system}.default
  ];

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
