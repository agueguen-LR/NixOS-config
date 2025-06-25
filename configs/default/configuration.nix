{ pkgs, ... }:

{
  imports =
    [ 
      ../common-config.nix
    ];

  system.nixos.tags = [ "default" ];

  home-manager.users.adrien = import ./home.nix;
    
  users.users.adrien.packages = with pkgs; [];
}
