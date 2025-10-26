{outputs, ...}: let
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
  ];

  networking = {
    hostName = "nixos-pc";
    hostId = "466b81e1"; # Needed for ZFS
  };

  home-manager.users.adrien.hostSpec = hostSpecs;
  hostSpec = hostSpecs;
}
