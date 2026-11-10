{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "qtile";

  nixos.services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };
}
