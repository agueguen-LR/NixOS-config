{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.greetd.tuigreet;
in {
  options.services.greetd.tuigreet = {
    enable = lib.mkEnableOption "Enable tuigreet as greetd greeter.";
    command = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Command to run with tuigreet --cmd";
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd ${cfg.command}";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
