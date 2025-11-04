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
		modules.catppuccin
    modules.fish
    modules.neovim
    modules.mango
    modules.tuigreet
    modules.virt-manager
  ];

  system.nixos.tags = ["mangoWC"];

  services.greetd.tuigreet = {
    enable = true;
    command = "mango";
  };

  virtualisation = {
    enable = true;
    users = [config.hostSpec.username];
  };

  boot.kernelModules = ["cp210x"];

  catppuccin.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username} = {
    packages = with pkgs; [
      acpi #battery info
      btop
      fastfetch
      grim # screenshots
      librewolf
      pavucontrol #volume control
      ripgrep #nvim telescope live_grep
      slurp # screenshots
      sysstat #system info commands: iostat mpstat pidstat ...
      tree
      unzip
      wl-clipboard
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
