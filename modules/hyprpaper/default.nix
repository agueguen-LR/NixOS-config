{
  lib,
  root,
  config,
  mkFeature,
  ...
}:
mkFeature config {
  name = "hyprpaper";

  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = root + /hosts/workstations/_wallpapers/catppuccin-nixos.png;
    description = "Wallpaper image to use with Hyprpaper.";
  };

  home.services.hyprpaper = {
    enable = true;
    settings = {
      preload = [(toString config.features.hyprpaper.wallpaper)];
      wallpaper = [",${toString config.features.hyprpaper.wallpaper}"];
    };
  };
}
