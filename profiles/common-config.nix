# This contains everything that's shared across profiles
{
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/hostSpec.nix
    outputs.nixosModules.home-manager
  ];

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

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };

  networking.networkmanager.enable = true;

  console = {
    keyMap = config.hostSpec.keyboard.layout;
    font = "Lat2-Terminus16";
  };

  services = {
    blueman.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  users = {
    mutableUsers = false;
    users.${config.hostSpec.username} = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    };
  };

  nix.settings.trusted-users = ["root" "@wheel"];

  programs = {
    fuse.userAllowOther = true; # see https://github.com/nix-community/impermanence#home-manager
    nix-ld.enable = true;
  };

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
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
