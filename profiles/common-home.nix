{ inputs, ...}:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./hm-persistence.nix
  ];

  home.username = "adrien";
  home.homeDirectory = "/home/adrien";

  services.ssh-agent.enable = true;

  home.stateVersion = "25.05"; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
