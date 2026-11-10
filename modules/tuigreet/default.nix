{
  mkFeature,
  pkgs,
  lib,
  config,
  ...
}:
mkFeature config {
  name = "tuigreet";

  options.command = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Command to run with tuigreet --cmd";
  };

  nixos = {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${config.features.tuigreet.command}";
        user = "greeter";
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
