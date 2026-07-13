{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    autoEnable = true;
    enable = true;
    cache.enable = true;
  };
}
