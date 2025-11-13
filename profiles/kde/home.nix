{
  outputs,
  lib,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    modules.catppuccin
    modules.fish
    modules.kitty
    modules.nixcord
    modules.nixvim
    modules.librewolf
  ];

  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';
}
