{
  mkFeature,
  config,
  lib,
  ...
}:
mkFeature config {
  name = "rofi";

  nixos = {
    hostSpecs.quickActions.appLauncher = lib.mkDefault ["rofi"];
  };

  home.programs.rofi = {
    enable = true;
    modes = ["drun"];
  };
}
