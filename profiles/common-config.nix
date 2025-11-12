# This contains everything that's shared across profiles
{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./persistence.nix
    ../modules/hostSpec.nix
    outputs.nixosModules.home-manager
    inputs.disko.nixosModules.disko
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
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  console.font = "Lat2-Terminus16";

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  users.mutableUsers = false;

  users.users.${config.hostSpec.username} = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  programs.fuse.userAllowOther = true; # see https://github.com/nix-community/impermanence#home-manager
  programs.nix-ld.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
