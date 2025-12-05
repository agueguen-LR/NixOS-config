{
  config,
  pkgs,
  ...
}:
{
	programs.virt-manager.enable = true;

	users.groups.libvirtd.members = [config.hostSpec.username];

	virtualisation.libvirtd = {
		enable = true;
		qemu.vhostUserPackages = [pkgs.virtiofsd];
	};

	virtualisation.spiceUSBRedirection.enable = true;
}
