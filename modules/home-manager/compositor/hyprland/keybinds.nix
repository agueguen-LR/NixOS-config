{
  input = {
    kb_layout = "fr";
    kb_options = "eurosign:e,caps:escape";
    numlock_by_default = true;
  };


  bind = [
    "$mod, B, exec, librewolf"                # Open browser
    "$mod, T, exec, kitty"                		# Open terminal
    "$mod, D, exec, vesktop"                  # Open discord
    "$mod, Y, exec, kitty yazi"               # Open yazi file explorer

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

    "$mod, code:10, workspace, 1"
    "$mod, code:11, workspace, 2"
    "$mod, code:12, workspace, 3"
    "$mod, code:13, workspace, 4"
    "$mod, code:14, workspace, 5"
    "$mod, code:15, workspace, 6"
    "$mod, code:16, workspace, 7"
    "$mod, code:17, workspace, 8"
    "$mod, code:18, workspace, 9"
    "$mod, code:19, workspace, 0"

    "$mod CTRL, code:10, movetoworkspace, 1"
    "$mod CTRL, code:11, movetoworkspace, 2"
    "$mod CTRL, code:12, movetoworkspace, 3"
    "$mod CTRL, code:13, movetoworkspace, 4"
    "$mod CTRL, code:14, movetoworkspace, 5"
    "$mod CTRL, code:15, movetoworkspace, 6"
    "$mod CTRL, code:16, movetoworkspace, 7"
    "$mod CTRL, code:17, movetoworkspace, 8"
    "$mod CTRL, code:18, movetoworkspace, 9"
    "$mod CTRL, code:19, movetoworkspace, 0"

    "$mod, Tab, movewindow, mon:+1"           # Move window to next monitor

    "$mod, Space, togglefloating"             # Toggle the focused window between tiled and floating modes

    "$mod, F, fullscreen, 1"                  # Maximize window

    ", Print, exec, grimblast copysave area"      # Screenshot

  ];
}

