{pkgs, ...}: let
  keybinds = import ./keybinds.nix;
in {
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set langmap=zw,wz
    ''; # Swap keys for azerty
  };

  programs.nvf = {
    enable = true;

    settings.vim = {
      autopairs.nvim-autopairs.enable = true;

      keymaps = keybinds.keymaps;

      utility.images.image-nvim = {
        enable = true;
        setupOpts.backend = "kitty";
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
      #autocomplete.nvim-cmp.enable = true;
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
      };

      options = {
        shiftwidth = 2;
        tabstop = 2;
      };

      debugger.nvim-dap = {
        enable = true;
        mappings = {};
        sources = {};
        ui.enable = true;
      };

      lsp.enable = true;
      languages = {
        enableTreesitter = true;
        enableDAP = true;

        nix = {
          enable = true;
          lsp.server = "nixd";
        };

        clang = {
          # c and c++
          enable = true;
          lsp.server = "clangd";
          dap.enable = true;
        };

        java.enable = true;

        python = {
          enable = true;
          format.enable = true;
          dap.enable = true;
        };
      };

      extraPlugins = {
        nvim-java.package = pkgs.vimPlugins.nvim-java;
        nvim-java-dap.package = pkgs.vimPlugins.nvim-java-dap;
        nvim-java-test.package = pkgs.vimPlugins.nvim-java-test;
        nvim-java-refactor.package = pkgs.vimPlugins.nvim-java-refactor;
        nvim-java-core.package = pkgs.vimPlugins.nvim-java-core;
      };
    };
  };
}
