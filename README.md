# NixOS-config

Dotfiles for my NixOS setup, implementing system and home configuration for 3 different hosts: 'pc', 'laptop' and 'server'.

## Hosts

Hosts are per-device configurations, defining the majority of system and per-user configuration.


To avoid code duplication, sharing relevant configuration between all hosts is done through [./hosts/shared-config.nix](./hosts/shared-config.nix).


Sharing between specific hosts is done by creating sub-folders with their own shared-config.nix, which I currently only do for [workstations](./hosts/workstations/shared-config.nix) which need GUI (compositors, quickshells...) as opposed to my server.


Hosts can also provide general information by setting options defined in [options.nix](./options.nix) which will be used to avoid repeatedly needing to set common values such as username or keyboard settings.


## Modules

Modules are implemented in the [modules/](./modules/) directory with the mkFeature function defined in my [flake](./flake.nix).


They define complex configurations of isolated features (compositors, IDEs...) that can combine NixOS system and home-manager configuration, and can contain additional options for hosts to set.


They are [automatically imported](./modules/default.nix), must be stored in ./modules/<feature-name>/default.nix, and are enabled by hosts with:

```nix
features.<feature-name> = {
  enable = true;
  # additional options...
};
```


Modules should read options the hosts have set from [options.nix](./options.nix) to avoid to avoid re-defining more options asking for common information such as username or keyboard settings.

## Impermanence

My hosts use [ZFS impermanence](https://grahamc.com/blog/erase-your-darlings), as such, the root directory is reset at every reboot and only the files in the /persist directory or managed by the [impermanence module](https://github.com/nix-community/impermanence) are kept.


The filesystems are handled by [disko](https://github.com/nix-community/disko).

## Installation 

Boot into the [NixOS minimal installer](https://nixos.org/download/) and [connect to the internet with wpa](https://wiki.archlinux.org/title/Wpa_supplicant#Connecting_with_wpa_cli).


Clone this repository
```bash
git clone https://github.com/agueguen-LR/NixOS-config
cd NixOS-config
```

Copy a template from one of the disko configs in disko/ and modify it to your needs.
Choose the device you want to install to with ```lsblk``` and replace the device name with it 
```bash
cp disko/pc-disko.nix disko/<your-host>-disko.nix
nano disko/impermanence.nix
```

Run disko
```bash
sudo nix --experimental-features 'nix-command flakes' \
    run github:nix-community/disko/latest -- \
    --mode destroy,format,mount ./disko/<your-host>-disko.nix
```

Create your hardware-configuration.nix
```bash
sudo nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./hardware/<your-host>-hardware.nix
```

Create a host configuration and modify hosts/shared-config.nix or hosts/workstations/shared-config.nix for any extra settings you wish to share between hosts.
Create your hashed password and add it to initialHashedPassword.
> You might not want to share this password between hosts, modify commands accordingly, or handle that later, when moving to an agenix encrypted secret

>!! Also set your hostId to the first 8 characters of your machine-id found in /etc/machine-id if you're using ZFS !!
```bash
cp -r hosts/workstations/laptop hosts/workstations/<your-host>

# Appends to end of shared-config.nix, then copy-paste to users.users.${hostSpecs.username}.initialHashedPassword

mkpasswd <your-password> >> hosts/shared-config.nix
# Appends to end of <your-host>/default.nix, then copy-paste to networking.hostId
head -c 8 /etc/machine-id >> hosts/<your-host>/default.nix

nano hosts/shared-config.nix
nano hosts/<your-host>/default.nix
```

Edit flake.nix to set your desired nixosConfigurations
> !!! It may be good to remove the others to avoid building them, as that could break things by loading wrong hardware configs, or break ZFS by loading the wrong hostId. 
```bash
nano flake.nix
```
```nix
nixosConfigurations = {
  <your-host> = mkHost "<path-to-host-config>";
  # ...
};
```

Move this repo to /mnt/etc/nixos
```bash
sudo mv ./* /mnt/etc/nixos
cd /mnt/etc/nixos
```

Install your configuration and reboot
```bash
sudo nixos-install --flake .#<your-host>
reboot
```

Replace your hashedPassword with an agenix encrypted secret if you wish to version control your config with git
```bash
cd /etc/nixos/secrets
mkpasswd <your-password> #copy this to paste in agenix -e
agenix -e user-password.age -i <path-to-your-ssh-identity>
cd ..
vim hosts/<your-host>.nix
```
```nix
age = {
identityPaths = [ "<path-to-your-ssh-identity>" ];
secrets.user-password.file = ../secrets/user-password.age;
};
users.users.${hostSpecs.username}.hashedPasswordFile = config.age.secrets.user-password.path;
```

Following steps can be version-controlling your configuration and moving your configuration into a .dotfiles directory out of /etc/nixos

