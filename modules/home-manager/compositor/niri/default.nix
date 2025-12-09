# No enable here, instead import the NixOS module and enable niri there.
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.hostSpec.monitor;
  monitorAttrs =
    lib.lists.imap0 (i: name: {
      name = name;
      value = {
        mode.width = builtins.elemAt cfg.width i;
        mode.height = builtins.elemAt cfg.height i;
        mode.refresh = builtins.elemAt cfg.refreshRate i;
        position.x = builtins.elemAt cfg.xoffset i;
        position.y = builtins.elemAt cfg.yoffset i;
      };
    })
    cfg.name;
in {
  home.packages = [
    pkgs.xwayland-satellite
  ];

  programs.niri.settings = {
    input.keyboard = {
      numlock = true;
      xkb = {
        layout = config.hostSpec.keyboard.layout;
        options = config.hostSpec.keyboard.options;
      };
    };

    outputs = builtins.listToAttrs monitorAttrs;

    cursor = {
      size = 12;
    };
    prefer-no-csd = true;

    gestures.hot-corners.enable = false;

    layout = {
      gaps = 8;
      struts = {
        top = 0;
        bottom = -2;
      };
      always-center-single-column = true;
    };

    hotkey-overlay = {
      hide-not-bound = false;
      skip-at-startup = true;
    };

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
      }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+T".action = lib.mkDefault (spawn "${pkgs.alacritty}/bin/alacritty");
      "Mod+Q".action = close-window;
      "Mod+O".action = toggle-overview;

      "Print".action = spawn "sh" "-c" ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy'';

      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;

      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
      "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;

      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+Up".action = focus-workspace-up;
      "Mod+Shift+Down".action = focus-workspace-down;

      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;

      "Mod+WheelScrollDown" = {
        action = focus-workspace-down;
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action = focus-workspace-up;
        cooldown-ms = 150;
      };
      "Mod+Shift+WheelScrollDown" = {
        action = focus-column-right;
        cooldown-ms = 150;
      };
      "Mod+Shift+WheelScrollUp" = {
        action = focus-column-left;
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action = move-column-to-workspace-down;
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action = move-column-to-workspace-up;
        cooldown-ms = 150;
      };
      "Mod+Shift+Ctrl+WheelScrollDown" = {
        action = move-column-right;
        cooldown-ms = 150;
      };
      "Mod+Shift+Ctrl+WheelScrollUp" = {
        action = move-column-left;
        cooldown-ms = 150;
      };

      "Mod+Comma".action = consume-or-expel-window-left;
      "Mod+Semicolon".action = consume-or-expel-window-right;

      "Mod+N".action = switch-preset-column-width;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+F".action = maximize-column;
      "Mod+C".action = center-column;

      "Mod+Tab".action = toggle-window-floating;

      "Mod+Escape" = {
        action = toggle-keyboard-shortcuts-inhibit;
        allow-inhibiting = false;
      };
    };

    debug = {
      honor-xdg-activation-with-invalid-serial = [];
    };

    # Startup applications
    spawn-at-startup = [
      {command = ["xwayland-satellite"];}
    ];
  };
}
