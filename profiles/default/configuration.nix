{config, ...}: {
  imports = [
  ];

  system.nixos.tags = ["default"];

  home-manager.users.${config.hostSpec.username} = import ./home.nix;
}
