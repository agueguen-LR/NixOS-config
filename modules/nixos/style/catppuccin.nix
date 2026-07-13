{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    autoEnable = true;
    enable = true;
    cache.enable = true;
  };
}
