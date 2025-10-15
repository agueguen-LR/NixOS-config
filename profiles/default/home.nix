{pkgs, ...}: {
  imports = [
    ../common-home.nix
  ];

  home.packages = with pkgs; [];

  home.file = {};

  home.sessionVariables = {};
}
