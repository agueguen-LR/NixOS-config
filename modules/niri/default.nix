{
  pkgs,
  config,
  lib,
  mkFeature,
  ...
}: let
  keybindKdl = let
    binds =
      lib.filterAttrs (
        action: _: builtins.hasAttr action config.hostSpecs.quickActions
      )
      config.hostSpecs.keybinds;

    mkBind = action: key: ''
      ${key} { spawn ${lib.concatMapStringsSep " " builtins.toJSON config.hostSpecs.quickActions.${action}}; }
    '';
  in
    lib.concatStringsSep "" (
      lib.mapAttrsToList mkBind binds
    );

  cfg = config.hostSpecs.monitor;
  monitorKdl = lib.concatMapStringsSep "" (i: ''
    output "${builtins.elemAt cfg.name i}" {
      mode "${toString (builtins.elemAt cfg.width i)}x${toString (builtins.elemAt cfg.height i)}@${toString (builtins.elemAt cfg.refreshRate i)}"
      position x=${toString (builtins.elemAt cfg.xoffset i)} y=${toString (builtins.elemAt cfg.yoffset i)}
      transform "normal"
    }
  '') (lib.range 0 (builtins.length cfg.name - 1));

  keyboardKdl = ''
    xkb {
    	layout "${config.hostSpecs.keyboard.layout}"
    	model ""
    	rules ""
    	variant ""
    	options "${config.hostSpecs.keyboard.options}"
    }
  '';
in
  mkFeature config {
    name = "niri";

    options.runOnLaunch = lib.mkOption {
      type = lib.types.listOf (lib.types.listOf lib.types.str);
      default = [];
      example = [
        ["dms" "run" "-d"]
        ["noctalia"]
      ];
      description = "Commands to execute when Niri starts.";
    };

    nixos = {
      system.nixos.tags = ["niri"];

      programs.niri = {
        enable = true;
        package = pkgs.niri; # optional
      };

      environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Enable Electron-based applications on Wayland
    };

    home = {
      home.packages = [
        pkgs.xwayland-satellite
      ];

      xdg.configFile."niri/config.kdl".source =
        pkgs.runCommand "niri-config-checked"
        {
          nativeBuildInputs = [pkgs.niri];
        }
        ''
          substitute ${./config.kdl} $out \
            --replace-fail "// @MONITORS@" '${monitorKdl}' \
            --replace-fail "// @KEYBOARD@" '${keyboardKdl}' \
            --replace-fail "// @BINDS@" '${keybindKdl}' \
            --replace-fail "// @STARTUP@" '${
            lib.concatMapStringsSep "\n" (
              command: ''spawn-at-startup ${
                  lib.concatMapStringsSep " " builtins.toJSON command
                } ''
            )
            config.features.niri.runOnLaunch
          }'
          niri validate --config $out
        '';
    };
  }
