{
  inputs,
  pkgs,
	config,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ./hm-persistence.nix
    ../modules/hostSpec.nix
  ];

  home.username = config.hostSpec.username;
  home.homeDirectory = "/home/${config.hostSpec.username}";

  services = {
    ssh-agent.enable = true;
  };
  programs.gpg.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
