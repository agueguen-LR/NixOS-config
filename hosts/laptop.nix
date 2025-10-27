{...}: let
  hostSpecs = {
    username = "adrien";
  };
in {
  imports = [
    ../hardware/laptop-hardware.nix
    ../disko/laptop-disko.nix
    ../modules/hostSpec.nix
  ];

  networking = {
    hostName = "nixos-laptop";
    hostId = "81cd2a4d"; # Needed for ZFS
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  home-manager.users.${hostSpecs.username}.hostSpec = hostSpecs;
  hostSpec = hostSpecs;
}
