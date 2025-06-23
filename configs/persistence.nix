{
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/nixos" #see https://github.com/nix-community/impermanence/issues/178
      "/etc/NetworkManager/system-connections"
    ];
    files = [];
  };
}
