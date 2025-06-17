{
  input = {
    kb_layout = "fr";
    kb_options = "caps:escape";
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
    "$mod SHIFT, H, swapwindow, l"           # Swap tiled window left
    "$mod SHIFT, L, swapwindow, r"           # Swap tiled window right
    "$mod SHIFT, K, swapwindow, u"           # Swap tiled window up
    "$mod SHIFT, J, swapwindow, d"           # Swap tiled window down

    "$mod, F, fullscreen, 1"                  # Maximize window

    ", Print, exec, grimblast copy area"      # Screenshot
  ];
}

