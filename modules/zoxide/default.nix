{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "zoxide";
  home.programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
