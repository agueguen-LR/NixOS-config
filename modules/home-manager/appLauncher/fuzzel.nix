{ pkgs, ... }:
{
	programs.fuzzel = {
		enable = true;
		settings.main.terminal = "${pkgs.fish}/bin/fish";
	};
}
