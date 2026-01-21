{inputs, ...}: let
  keybinds = import ./keybinds.nix;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      autopairs.nvim-autopairs.enable = true;

      keymaps = keybinds.keymaps;

      utility.images.image-nvim = {
        enable = true;
        setupOpts.backend = "kitty";
      };

      visuals = {
        indent-blankline.enable = true;
        nvim-web-devicons.enable = true;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      terminal.toggleterm = {
        enable = true;
        lazygit = {
          enable = true;
          direction = "float";
          mappings.open = "<leader>g";
        };
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      filetree.neo-tree.enable = true;
      tabline.nvimBufferline.enable = true;

      binds.whichKey = {
        enable = true;
      };

      mini = {
        ai.enable = true;
        fuzzy.enable = true;
        git.enable = true;
        surround.enable = true;
        completion.enable = true;
        comment.enable = true;
      };

      clipboard = {
        enable = true;
        providers = {
          wl-copy.enable = true;
        };
        registers = "unnamedplus";
      };

      options = {
        shiftwidth = 2;
        tabstop = 2;
      };

      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      formatter.conform-nvim = {
        enable = true;
      };

      lsp = {
        enable = true;
        otter-nvim.enable = true;
        formatOnSave = true;
      };

      languages = {
        enableTreesitter = true;
        enableDAP = true;
        enableFormat = true;

        nix = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        clang = {
          # c and c++
          enable = true;
          lsp.enable = true;
          dap.enable = true;
          treesitter.enable = true;
        };

        java = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        python = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
          dap.enable = true;
          treesitter.enable = true;
        };

        rust = {
          enable = true;
          format.enable = true;
          dap.enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
      };
    };
  };
}
