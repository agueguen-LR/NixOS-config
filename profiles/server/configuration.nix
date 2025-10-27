{
  pkgs,
  inputs,
  outputs,
	config,
  ...
}: let
  modules = outputs.nixosModules;
in {
  imports = [
    ../common-config.nix
    modules.neovim
    modules.fish
  ];

  system.nixos.tags = ["server"];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username} = {
    packages = with pkgs; [
      btop
      fastfetch
      tree
      acpi #battery info
      sysstat #system info commands: iostat mpstat pidstat ...
      wl-clipboard
      unzip
    ];
    shell = pkgs.fish;
  };

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
