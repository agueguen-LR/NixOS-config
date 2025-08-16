{ ... }:
let
  keybinds = import ./keybinds.nix;
in
{
	imports = [
		./nixvim-dap.nix
	];
  programs.nixvim = {
    enable = true;
    globalOpts = {
      shiftwidth = 2;
      tabstop = 2; 
    };
    extraConfigVim = "
			set langmap=zw,wz
			let mapleader = ' '
		";
		extraConfigLua = "vim.g.mapleader = ' '";

    keymaps = keybinds.keymaps;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };
    
    plugins = {
			dap.enable = true; # debugging
			image.enable = true;
			lazygit.enable = true;
      lualine.enable = true;
			lspconfig.enable = true;
			markdown-preview.enable = true;
      toggleterm.enable = true;
      neo-tree.enable = true;
      bufferline.enable = true;
      which-key.enable = true;
      web-devicons.enable = true;
      mini = {
        enable = true;
        modules = {
          ai = {};
          fuzzy = {};
          git = {};
          surround = {};
          completion = {};
        };
      };
    };

    clipboard.providers.wl-copy.enable = true;

    lsp.servers = {
      nixd.enable = true;
      clangd.enable = true;
      java_language_server.enable = true;
      cmake.enable = true;
      pylsp.enable = true;
    };
    
  };
}
