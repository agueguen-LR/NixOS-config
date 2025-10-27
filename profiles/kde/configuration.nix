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
    modules.neovim
    modules.zsh
    modules.steam
  ];

  system.nixos.tags = ["kde"];

  services = {
    xserver = {
      xkb.layout = "fr";
      xkb.options = "eurosign:e,caps:escape";
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username} = {
    packages = with pkgs; [
      btop
      fastfetch
      alacritty
      pavucontrol #volume control
      tree
      acpi #battery info
      sysstat #system info commands: iostat mpstat pidstat ...
      librewolf
      wl-clipboard
      unzip
    ];
    shell = pkgs.zsh;
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
