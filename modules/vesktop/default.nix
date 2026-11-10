{
  mkFeature,
  pkgs,
  lib,
  config,
  ...
}:
mkFeature config {
  name = "vesktop";

  home = {
    # for impermanence, make sure config folder exists
    home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ~/.config/discord
    '';

    home.packages = with pkgs; [
      vesktop
    ];
  };
}
