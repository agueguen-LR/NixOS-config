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
    modules.neovim
    modules.niri
    modules.fish
    modules.tuigreet
    modules.virt-manager
  ];

  system.nixos.tags = ["niri"];

  services.tuigreet = {
    enable = true;
    command = "niri";
  };

  virtualisation = {
    enable = true;
    users = [config.hostSpec.username];
  };

  boot.kernelModules = ["cp210x"];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username} = {
    packages = with pkgs; [
      btop
      fastfetch
      librewolf
      pavucontrol #volume control
      sysstat #system info commands: iostat mpstat pidstat ...
      wl-clipboard
    ];
    shell = pkgs.fish;
  };

  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
