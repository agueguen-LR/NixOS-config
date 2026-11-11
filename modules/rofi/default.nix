{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "rofi";

  nixos = {
    hostSpecs.quickActions.appLauncher = ["rofi"];
  };

  home.programs.rofi = {
    enable = true;
    modes = ["drun"];
  };
}
