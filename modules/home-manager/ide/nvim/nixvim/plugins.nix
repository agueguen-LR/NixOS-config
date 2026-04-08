{
  lib,
  pkgs,
  ...
}: {
  # Make ripgrep available to telescope
  home.packages = with pkgs; [
    ripgrep
  ];

  # Allow unfree copilot plugins
  programs.nixvim.nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "copilot.vim"
    ];

  programs.nixvim.plugins = {
    bufferline.enable = true;
    copilot-chat.enable = true;
    copilot-vim.enable = true;
    indent-blankline.enable = true;
    lazygit.enable = true;
    lualine.enable = true;
    lspconfig.enable = true;
    markdown-preview.enable = true;
    oil.enable = true;
    otter.enable = true;
    # quarto.enable = true;
    telescope.enable = true;
    toggleterm.enable = true;
    # neo-tree = {
    #   enable = true;
    #   log_to_file = true;
    # };
    nvim-autopairs.enable = true;
    which-key.enable = true;
    web-devicons.enable = true;
    yazi.enable = true;

    conform-nvim = {
      enable = true;
      settings = {
        log_level = "debug";
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = false;
        };
        formatters_by_ft = {
          nix = ["alejandra"];
          python = ["ruff_format"];
          rust = ["rustfmt"];
          java = ["google-java-format"];
          kotlin = [];
        };
        formatters = {
          alejandra.command = lib.getExe pkgs.alejandra;
          ruff_format.command = lib.getExe pkgs.ruff;
          rustfmt.command = lib.getExe pkgs.rustfmt;
          google-java-format.command = lib.getExe pkgs.google-java-format;
          ktfmt.command = lib.getExe pkgs.ktfmt;
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
  };
}
