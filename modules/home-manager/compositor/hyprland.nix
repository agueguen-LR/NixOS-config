{ ... }:
let
  keybinds = import ./hyprland/keybinds.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      general = {
        gaps_in = 1;
        gaps_out = 2;
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1.0;
      };


      "$mod" = "SUPER";

      input = keybinds.input;
      bind = keybinds.bind;
    };
  };
}
