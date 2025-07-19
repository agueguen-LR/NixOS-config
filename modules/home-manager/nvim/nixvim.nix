{ ... }:
let
  keybinds = import ./keybinds.nix;
in
{
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
			lazygit.enable = true;
      lualine.enable = true;
			lspconfig.enable = true;
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
