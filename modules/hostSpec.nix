# Module for managing host-specific configuration variables.
# This module needs to be imported into both the NixOS and Home Manager configurations to read the values with config.hostSpec.<var>,
# to set a value for use within NixOS configuration, you can directly set `hostSpec.<var>`,
# to set them in the NixOS context for home-manager, they need to be set under `home-manager.users.<username>.hostSpec.<var>`.
# https://unmovedcentre.com/posts/managing-nix-config-host-variables/ <-- my original inspiration, though far simpler here.
{lib, ...}: {
  options.hostSpec = {
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
  };
}
