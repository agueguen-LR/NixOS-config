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
    modules.niri
    modules.dankgreet
    modules.virt-manager
  ];

  system.nixos.tags = ["niri"];

  programs.dankMaterialShell.greeter.compositor = {
    name = "niri";
    customConfig = ''
      input {
      	keyboard {
      		xkb {
      			layout "${config.hostSpec.keyboard.layout}"
      			options "${config.hostSpec.keyboard.options}"
      		}
      		numlock
      	}
      }
      hotkey-overlay {
      	skip-at-startup
      }
    '';
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  home-manager.users.${config.hostSpec.username} = import ./home.nix;

  users.users.${config.hostSpec.username} = {
    packages = with pkgs; [
      btop
      fastfetch
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
}
