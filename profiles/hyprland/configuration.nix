{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  modules = outputs.nixosModules;
in {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ../common-config.nix
    modules.neovim
    modules.hyprland
    modules.fish
    modules.tuigreet
  ];

  system.nixos.tags = ["hyprland"];

  boot.kernelModules = ["cp210x"];

  catppuccin.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.adrien = import ./home.nix;

  users.users.adrien = {
    packages = with pkgs; [
      btop
      fastfetch
      pavucontrol #volume control
      tree
      acpi #battery info
      sysstat #system info commands: iostat mpstat pidstat ...
      librewolf
      grimblast #screenshots
      wl-clipboard
      unzip
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
