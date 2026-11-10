{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "rofi";

  nixos = {
    hostSpecs.appLauncher = ["rofi"];
  };

  home.programs.rofi = {
    enable = true;
    modes = ["drun"];
  };
}
