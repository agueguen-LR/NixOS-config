{
  mkFeature,
  config,
  pkgs,
  ...
}:
mkFeature config {
  name = "virt-manager";

  nixos = {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [
      config.hostSpecs.username
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [pkgs.virtiofsd];
      };

      spiceUSBRedirection.enable = true;
    };
  };
}
