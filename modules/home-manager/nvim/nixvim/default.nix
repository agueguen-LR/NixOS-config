{lib, ...}: let
  keybinds = import ./keybinds.nix;
in {
  imports = [
    ./dap.nix
  ];
  programs.nixvim = {
    enable = true;
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "copilot.vim"
      ];

    opts = {
      number = true;
      relativenumber = true;
      splitright = true;
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

    clipboard.providers.wl-copy.enable = true;

    plugins = {
      bufferline.enable = true;
      copilot-chat.enable = true;
      copilot-vim.enable = true;
      indent-blankline.enable = true;
      lazygit.enable = true;
      lualine.enable = true;
      lspconfig.enable = true;
      markdown-preview.enable = true;
      otter.enable = true;
      quarto.enable = true;
      telescope.enable = true;
      toggleterm.enable = true;
      neo-tree.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      web-devicons.enable = true;

      image = {
        enable = true;
        settings = {
          max_height = 12;
          max_width = 100;
          max_height_window_percentage = {__raw = "math.huge";};
          max_width_window_percentage = {__raw = "math.huge";};
        };
      };

      molten = {
        #jupyter
        enable = true;
        settings = {
          auto_image_popup = true;
          image_provider = "image.nvim";
        };
      };

      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };

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
    }; # end of plugins

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
            "ino"
          ];
        };
      };
      java_language_server.enable = true;
      cmake.enable = true;
      pylsp.enable = true;
      pyright.enable = true;
    };
  };
}
