{
  input = {
    kb_layout = "fr";
    kb_options = "eurosign:e,caps:escape";
    numlock_by_default = true;
  };


  bind = [
    "$mod, B, exec, librewolf"                # Open browser
    "$mod, T, exec, alacritty"                # Open terminal
    "$mod, D, exec, vesktop"                  # Open discord

    "$mod, Q, killactive"                     # Kill active window
    "$mod, H, movefocus, l"                   # Move focus left
    "$mod, L, movefocus, r"                   # Move focus right
    "$mod, K, movefocus, u"                   # Move focus up
    "$mod, J, movefocus, d"                   # Move focus down
    "$mod SHIFT, H, swapwindow, l"            # Swap tiled window left
    "$mod SHIFT, L, swapwindow, r"            # Swap tiled window right
    "$mod SHIFT, K, swapwindow, u"            # Swap tiled window up
    "$mod SHIFT, J, swapwindow, d"            # Swap tiled window down
    "$mod CTRL, H, resizeactive, -80 0"       
    "$mod CTRL, J, resizeactive, 0 80"
    "$mod CTRL, K, resizeactive, 0 -80"
    "$mod CTRL, L, resizeactive, 80 0"
    "$mod ALT, h, moveactive,  -80 0"
    "$mod ALT, j, moveactive, 0 80"
    "$mod ALT, k, moveactive, 0 -80"
    "$mod ALT, l, moveactive, 80 0"

    "$mod, Tab, movewindow, mon:+1"           # Move window to next monitor

    "$mod, Space, togglefloating"             # Toggle the focused window between tiled and floating modes

    "$mod, F, fullscreen, 1"                  # Maximize window

    ", Print, exec, grimblast copy area"      # Screenshot

  ];
}

