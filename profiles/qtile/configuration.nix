{
  pkgs,
  outputs,
  config,
  ...
}: let
  modules = outputs.nixosModules;
in {
  imports = [
    ../common-config.nix
    modules.catppuccin
    modules.fish
    modules.neovim
    modules.qtile
    modules.virt-manager
  ];

  system.nixos.tags = ["qtile"];

  services.xserver.xkb = {
    layout = config.hostSpec.keyboard.layout;
    options = config.hostSpec.keyboard.options;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username} = {
    packages = with pkgs; [
      btop
      fastfetch
      pavucontrol
      acpi
      sysstat
    ];
    shell = pkgs.fish;
  };

  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
