{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, librewolf"
        "$mod, T, exec, alacritty"
      ];
    };
  };
}
