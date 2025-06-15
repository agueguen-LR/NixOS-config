{ ... }:
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

      input = {
        kb_layout = "fr, ca";
        kb_variant = ", fr";
        kb_options = "grp:ctrl_shift_toggle, caps:escape";
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, F, exec, librewolf"
        "$mod, T, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, D, exec, discord"
      ];

    };
  };
}
