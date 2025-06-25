{ inputs, ...}:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./hm-persistence.nix
  ];

  home.username = "adrien";
  home.homeDirectory = "/home/adrien";

  home.stateVersion = "25.05"; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
