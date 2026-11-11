{
  inputs,
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "catppuccin";

  nixosImports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  hmImports = [
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
