{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./hm-persistence.nix
		../modules/hostSpec.nix
  ];

  home.username = "adrien";
  home.homeDirectory = "/home/adrien";

  services = {
    ssh-agent.enable = true;
  };
  programs.gpg.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
