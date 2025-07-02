{ ... }:
let
  keybinds = import ./hyprland/keybinds.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      monitor = ", preferred, auto, 1";

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

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      "$mod" = "SUPER";

      input = keybinds.input;
      bind = keybinds.bind;
    };
  };
}
