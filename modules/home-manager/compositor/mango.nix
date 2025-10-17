{ lib, ... }:
{
  wayland.windowManager.mango = {
    enable = true;
    settings = lib.readFile ./mango/config.conf;
    autostart_sh = ''
      swww img "${builtins.toString ../wallpaper/catppuccin-nixos.png}"
    '';
  };
}
