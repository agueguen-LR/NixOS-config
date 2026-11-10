{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "fzf";

  home.programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
