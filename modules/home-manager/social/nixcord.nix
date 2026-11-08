{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  # for impermanence, make sure config folder exists
  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';

  home.packages = with pkgs; [
    vesktop
  ];
}
