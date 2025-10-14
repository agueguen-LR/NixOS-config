{ ... }:
let
  keybinds = import ./keybinds/nixvim_keys.nix;
in
{
	imports = [
		./nixvim-dap.nix
	];
  programs.nixvim = {
    enable = true;
		opts = {
			relativenumber = true;
		};
		globals = {
			mapleader = " ";
		};
    globalOpts = {
      shiftwidth = 2;
      tabstop = 2; 
    };

    keymaps = keybinds.keymaps;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };
    
    plugins = {
      bufferline.enable = true;
			dap.enable = true; # debugging
			image = {
				enable = true;
				settings = {
					max_height = 12;
					max_width = 100;
					max_height_window_percentage = {__raw = "math.huge";};
					max_width_window_percentage = {__raw = "math.huge";};
				};
			};
			lazygit.enable = true;
      lualine.enable = true;
			lspconfig.enable = true;
			markdown-preview.enable = true;
			molten = { #jupyter
				enable = true;
				settings = {
					auto_image_popup = true;
					image_provider = "image.nvim";
				};
			};
			quarto.enable = true;
			otter.enable = true;
      toggleterm.enable = true;
			treesitter = {
				enable = true;
				settings.highlight.enable = true;
			};
      neo-tree.enable = true;
			nvim-autopairs.enable = true;
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
      clangd = {
				enable = true;
				settings = {
					filetypes = [
						"c"
						"cpp"
						"h"
						"inc"
					];
				};
			};
      java_language_server.enable = true;
      cmake.enable = true;
      pylsp.enable = true;
    };
    
  };
}
