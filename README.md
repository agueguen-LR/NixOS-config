# NixOS-config

Dotfiles for my NixOS setup, currently there are six available profiles.


Each profile is used with a host configuration file for hardware/user specific additions.


The default profile is a completely bare installation with only git and vim.
```bash
sudo nixos-rebuild switch --flake .#<host>-default
```


The qtile profile comes with the X11 window manager [Qtile](https://qtile.org/).
```bash
sudo nixos-rebuild switch --flake .#<host>-qtile
```


The hyprland profile comes with the wayland compositor [Hyprland](https://hypr.land/).
```bash
sudo nixos-rebuild switch --flake .#<host>-hypr
```


The mango profile comes with the wayland compositor [MangoWC](https://github.com/DreamMaoMao/mangowc).
```bash
sudo nixos-rebuild switch --flake .#<host>-mango
```


The niri profile comes with the wayland compositor [Niri](https://github.com/YaLTeR/niri).
```bash
sudo nixos-rebuild switch --flake .#<host>-niri
```


The kde profile comes with the desktop environment [KDE Plasma 6](https://kde.org/plasma-desktop/).
```bash
sudo nixos-rebuild switch --flake .#<host>-kde
```

## Profiles vs Hosts

Every configuration is a combination of a profile and a host. In general (ideally), a profile should work as expected independently of the specific machine — meaning it should not depend on the user’s filesystem, username, location, language, etc.


The host defines all these user/machine-specific parameters. You can share common settings between hosts using [hosts/shared-config.nix](./hosts/shared-config.nix), like username or language, while [each host](./hosts/laptop/default.nix) imports their own hardware-configuration and sets their own machine-id.


The [hostSpec module](./modules/hostSpec.nix) is the only channel through which profiles and hosts communicate.
It allows modules and profiles to access host-specific information (such as monitor info or username) during their configuration. This is the only module that must be imported by both hosts and profiles: hosts set its values, and profiles (or other modules) read them.


Thanks to hostSpec, modules can be written to be host-independent and are therefore typically used within profiles.
However, hosts can import modules directly if you want them to be available only for that specific host.
Just keep the host–profile separation in mind — in many cases, it’s cleaner to create a new profile for a host than to add modules directly to the host definition.

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

Create a host configuration for any "machine-specific" configuration and modify hosts/shared-config.nix for any extra settings you wish to share between hosts.
Create your hashed password and add it to initialHashedPassword.
!! Also set your hostId to the first 8 characters of your machine-id found in /etc/machine-id if you're using ZFS !!
```bash
cp -r hosts/laptop hosts/<your-host>

#appends to end of shared-config.nix, then copy-paste to users.users.${hostSpecs.username}.initialHashedPassword
mkpasswd <your-password> >> hosts/shared-config.nix
#appends to end of <your-host>/default.nix, then copy-paste to networking.hostId
head -c 8 /etc/machine-id >> hosts/<your-host>/default.nix

nano hosts/shared-config.nix
nano hosts/<your-host>/default.nix
```

Edit flake.nix to set your desired nixosConfigurations
> !!! You should remove the others to avoid building them, as that could break things by loading wrong hardware configs, or break ZFS by loading the wrong hostId. 
```bash
nano flake.nix
```
```nix
nixosConfigurations = {
  <your-host>-kde = mkHost "<your-host>.nix" "kde/configuration.nix";
  <your-host>-<other-profile> = mkHost "<your-host>.nix" "<other-profile>/configuration.nix";
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
sudo nixos-install --flake .#<your-chosen-config>
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

