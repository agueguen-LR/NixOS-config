{
  lib,
  pkgs,
  inputs,
  mkFeature,
  config,
  ...
}: let
  oled = {
    mocha = {
      base = "000000";
      mantle = "010101";
      crust = "020202";
    };
  };

  catppuccinPackages =
    inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system};

  oledSources = catppuccinPackages.overrideScope (
    final: prev: {
      whiskers = pkgs.symlinkJoin {
        name = "whiskers-oled";

        paths = [prev.whiskers];

        nativeBuildInputs = [
          pkgs.makeBinaryWrapper
        ];

        postBuild = ''
          wrapProgram $out/bin/whiskers \
            --add-flag ${lib.escapeShellArg "--color-overrides=${builtins.toJSON oled}"}
        '';

        meta.mainProgram = "whiskers";
      };
    }
  );
in
  mkFeature config {
    name = "catppuccin";

    nixosImports = [
      inputs.catppuccin.nixosModules.catppuccin
    ];

    hmImports = [
      inputs.catppuccin.homeModules.catppuccin
    ];

    options = {
      oled = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Override catppuccin/nix sources to use OLEDppuccin theme. Requires non-cached compilation of 'whiskers'";
      };
    };

    nixos = {
      catppuccin = {
        autoEnable = true;
        enable = true;
        cache.enable = false;

        sources = lib.mkIf config.features.catppuccin.oled oledSources;
      };
    };

    home = {
      catppuccin = {
        autoEnable = true;
        enable = true;
        cache.enable = false;

        kitty.enable = false;

        sources = lib.mkIf config.features.catppuccin.oled oledSources;
      };
    };
  }
