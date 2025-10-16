{...}: let
  config = import ./mango/config.nix;
in {
  wayland.windowManager.mango = {
    enable = true;
    settings = config.config;
    autostart_sh = ''
      swww img "${builtins.toString ../wallpaper/catppuccin-nixos.png}"
    '';
  };
}
