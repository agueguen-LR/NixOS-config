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
    modules.fish
    modules.kitty
    modules.nixvim
  ];

  home.packages = with pkgs; [];

  home.file = {};

  home.sessionVariables = {};
}
