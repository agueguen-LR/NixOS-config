{
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/nixos" #see https://github.com/nix-community/impermanence/issues/178
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id" # networking.hostId first 8 chars
    ];
  };
}
