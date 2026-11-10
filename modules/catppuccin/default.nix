{
  inputs,
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "catppuccin";

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    inputs.catppuccin.homeModules.catppuccin
  ];

  nixos.catppuccin = {
    autoEnable = true;
    enable = true;
    cache.enable = true;
  };

  home.catppuccin = {
    autoEnable = true;
    enable = true;
    cache.enable = true;
  };
}
