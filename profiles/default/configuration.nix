{pkgs, config, ...}: {
  imports = [
    ../common-config.nix
  ];

  system.nixos.tags = ["default"];

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username}.packages = with pkgs; [];
}
