{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    modules.alacritty
		modules.catppuccin
		modules.fish
    modules.nixcord
    modules.nixvim
    modules.librewolf
  ];

  home.packages = with pkgs; [];

  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';

  home.file = {};

  home.sessionVariables = {};
}
