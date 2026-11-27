{
  mkFeature,
  pkgs,
  lib,
  config,
  ...
}:
mkFeature config {
  name = "xdg";

  options.defaultApps = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.str);
    default = {};
    example = {
      "application/pdf" = ["librewolf.desktop"];
      "image/*" = ["dev.noctalia.Noctalia.Annotator.desktop"];
    };
    description = "Additional application associations for MIME types.";
  };

  nixos = {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };

  home = {
    xdg = {
      enable = true;
      mime.enable = true;

      mimeApps = {
        enable = true;
        defaultApplications = config.features.xdg.defaultApps;
      };
    };
  };
}
