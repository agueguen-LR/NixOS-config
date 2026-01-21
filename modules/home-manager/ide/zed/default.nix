{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "nil"
    ];

    extraPackages = with pkgs; [
      nixd
      nil
      rustfmt
      alejandra
      cargo
    ];

    userKeymaps = [
      {
        "context" = "Editor && vim_mode == normal";
        "bindings" = {
          "space g" = "git_panel::ToggleFocus";
          "space t" = "terminal_panel::Toggle";
          "space b" = "project_panel::ToggleFocus";
          "space c" = "ai_panel::ToggleFocus";
        };
      }
      {
        "context" = "Workspace";
        "bindings" = {
          "space b t" = "workspace::ToggleAllDocks";
        };
      }
      {
        "context" = "Terminal";
        "bindings" = {
          "ctrl-w up" = "workspace::ActivatePaneUp";
          "ctrl-w j" = "workspace::ActivatePaneUp";
        };
      }
      {
        "context" = "Workspace";
        "bindings" = {
          "ctrl-w" = null;
        };
      }
      {
        "context" = "SettingsWindow";
        "bindings" = {
          "ctrl-w" = null;
        };
      }
      {
        "context" = "RulesLibrary";
        "bindings" = {
          "ctrl-w" = null;
        };
      }
      {
        "context" = "Terminal";
        "bindings" = {
          "ctrl-w" = null;
        };
      }
      {
        "context" = "Pane";
        "bindings" = {
          "ctrl-w" = null;
        };
      }
      {
        "bindings" = {
          "ctrl-q" = null;
        };
      }
    ];

    userSettings = {
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
      relative_line_numbers = true;
      tab_size = 2;
    };
  };
}
