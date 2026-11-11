{
  config,
  lib,
  mkFeature,
  ...
}:
mkFeature config {
  name = "fuzzel";

  options.terminal = lib.mkOption {
    type = lib.types.str;
    default = "bash";
    description = "Terminal command used by Fuzzel.";
  };

  nixos = {
    hostSpecs.quickActions.appLauncher = ["fuzzel"];
  };

  home.programs.fuzzel = {
    enable = true;
    settings.main.terminal = config.features.fuzzel.terminal;
  };
}
