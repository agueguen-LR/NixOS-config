{ config, lib, pkgs, ... }: let
	cfg = config.virtualisation;
in
{
	options.virtualisation = {
		enable = lib.mkEnableOption "Enable Virt-Manager GUI.";
		users = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
			description = "List of users to add to the libvirtd group for Virt-Manager access.";
		};
	};

	config = lib.mkIf cfg.enable {
		programs.virt-manager.enable = true;

		users.groups.libvirtd.members = cfg.users;

		virtualisation.libvirtd = {
			enable = true;
			qemu.vhostUserPackages = [ pkgs.virtiofsd ];
		};

		virtualisation.spiceUSBRedirection.enable = true;
	};
}
