{ pkgs, inputs, outputs, ... }:
let
  modules = outputs.nixosModules;
in
{
  imports =
    [
      inputs.catppuccin.nixosModules.catppuccin
      ../common-config.nix
      modules.fish
      modules.neovim
      modules.qtile
    ];

  system.nixos.tags = [ "qtile" ];

  catppuccin.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.adrien = import ./home.nix;

  users.users.adrien= {
    packages = with pkgs; [
      btop
      fastfetch
      pavucontrol
      tree
      acpi
      sysstat
      librewolf
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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
