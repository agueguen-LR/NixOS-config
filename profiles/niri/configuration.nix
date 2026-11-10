{
  pkgs,
  outputs,
  config,
  ...
}: let
  modules = outputs.nixosModules;
in {
  imports = [
    modules.catppuccin
    modules.fish
    modules.neovim
    modules.niri
    modules.dankgreet
    # modules.dank-material-shell
    modules.virt-manager
  ];

  system.nixos.tags = ["niri"];

  services.displayManager.dms-greeter.compositor = {
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
}
