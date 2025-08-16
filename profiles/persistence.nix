{
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/nixos" #see https://github.com/nix-community/impermanence/issues/178
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id" # networking.hostId first 8 chars
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
