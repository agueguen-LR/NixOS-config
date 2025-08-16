{ pkgs, inputs, outputs, lib, ... }:
let
  modules = outputs.homeManagerModules;
in
{
  imports = [
    ../common-home.nix
    inputs.nvf.homeManagerModules.default
    modules.fish
    modules.kitty
    modules.nvf
  ];

  home.packages = with pkgs; [];

  home.file = {};

  home.sessionVariables = {};
}
