{
  mkFeature,
  pkgs,
  config,
  ...
}:
mkFeature config {
  name = "xdg";

  nixos = {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  };

  home = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.enable = true;
    };
  };
}
