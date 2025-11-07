let
  wallpaperPath = ./wallpapers/catppuccin-nixos.png;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${builtins.toString wallpaperPath}"];
      wallpaper = [",${builtins.toString wallpaperPath}"];
    };
  };
}
