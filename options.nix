# Globally imported module that provides access to helpers functions and options that can be shared
# between many hosts or modules to avoid repeatedly setting values that are often reused in the codebase.
{
  lib,
  config,
  ...
}: let
  # Shorthand to write homeManager config from same context as NixOS config
  # Writes as: config = {<nixos options>} // hm {<home manager options>}
  hm = cfg: {
    home-manager.users.${config.hostSpecs.username} = cfg;
  };
in {
  config._module.args = {
    inherit hm;
  };

  options.hostSpecs = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "user";
      description = "Username for the host.";
    };

    keyboard = {
      layout = lib.mkOption {
        type = lib.types.str;
        default = "us";
        description = "Xkb keyboard layout";
      };
      options = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Xkb keyboard options";
      };
    };

    hasBattery = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the host has a battery.";
    };

    monitor = {
      name = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["eDP-1"];
        description = "List of monitor names.";
      };
      width = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [1920];
        description = "List of monitor widths in pixels.";
      };
      height = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [1080];
        description = "List of monitor heights in pixels.";
      };
      xoffset = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [0];
        description = "List of monitor X offsets in pixels.";
      };
      yoffset = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [0];
        description = "List of monitor Y offsets in pixels.";
      };
      refreshRate = lib.mkOption {
        type = lib.types.listOf lib.types.float;
        default = [60.0];
        description = "List of monitor refresh rates in Hz.";
      };
    };

    # Maps an action name to the keybind that triggers it.
    # Example: browser = "Mod+B";
    keybinds = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      example = {
        browser = "Mod+B";
        terminal = "Mod+T";
        screenshot = "Print";
      };
      description = ''
        Keybindings for host quick actions.

        Each attribute name identifies a quick action, and its value
        specifies the key combination used to trigger it.

        Only actions registered in hostSpecs.quickActions are effective.

        Modules that define compositors or desktop environments should implement these.
      '';
    };

    # Maps an action name to the command that gets executed.
    # Example: browser = [ "librewolf" ];
    quickActions = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = {};
      example = {
        browser = ["librewolf"];
        terminal = ["kitty"];
        screenshot = ["grim"];
      };
      description = ''
        Commands available as host quick actions.

        Each attribute name identifies an action, and its value is
        the command and arguments executed when that action is triggered.

        Keybindings can be assigned through hostSpecs.keybinds.

        Modules can register themselves as default quick actions that hosts can override.

        Modules that define compositors or desktop environments should implement these.
      '';
    };
  };
}
