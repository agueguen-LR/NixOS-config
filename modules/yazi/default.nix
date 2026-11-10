{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "yazi";

  home.programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings.mgr.show_hidden = true;

    shellWrapperName = "y";
  };
}
