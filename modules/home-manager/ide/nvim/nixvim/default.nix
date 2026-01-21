{
  pkgs,
  lib,
  inputs,
  ...
}: let
  keybinds = import ./keybinds.nix;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./dap.nix
  ];

  home.packages = with pkgs; [
    alejandra
    ripgrep
    ruff
    rustfmt
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

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

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
      # quarto.enable = true;
      telescope.enable = true;
      toggleterm.enable = true;
      neo-tree.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      web-devicons.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          log_level = "debug";
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
            nix = ["alejandra"];
            python = ["ruff_format"];
            rust = ["rustfmt"];
          };
        };
      };

      image = {
        enable = true;
        settings = {
          max_height = 12;
          max_width = 100;
          max_height_window_percentage = {__raw = "math.huge";};
          max_width_window_percentage = {__raw = "math.huge";};
        };
      };

      # molten = {
      #   #jupyter
      #   enable = true;
      #   settings = {
      #     auto_image_popup = true;
      #     image_provider = "image.nvim";
      #   };
      # };

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
      arduino_language_server = {
        enable = true;
        config = {
          cmd = [
            "${pkgs.arduino-language-server}/bin/arduino-language-server"
            "-cli"
            "${pkgs.arduino-cli}/bin/arduino-cli"
            "-clangd"
            "${pkgs.clang-tools}/bin/clangd"
            "-fqbn"
            "esp32:esp32:featheresp32" # You will need to change this to your board's fqdn for this to work
          ];
          root_markers = [
            "shell.nix"
          ];
        };
      };
      clangd = {
        enable = true;
        config.filetypes = [
          "c"
          "cpp"
          "h"
          "inc"
        ];
      };
      java_language_server.enable = true;
      cmake.enable = true;
      pylsp.enable = true;
      pyright.enable = true;
      nixd.enable = true;
      rust_analyzer.enable = true;
    };

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("FileType", {
      	callback = function()
      		vim.opt_local.shiftwidth = 2
      		vim.opt_local.tabstop = 2
      		vim.opt_local.softtabstop = 2
      	end
      })
    '';
  };
}
