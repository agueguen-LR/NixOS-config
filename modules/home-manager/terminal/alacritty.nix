{ ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
      };
      keyboard.bindings = [
        #{ key = 53; mods = "Shift"; mode = "Vi"; action = "SearchBackward"; }
        #{ key = "Return"; mods = "Shift"; chars = "\\x1b[13;2u"; }
        #{ key = "Return"; mods = "Control"; chars = "\\x1b[13;5u"; }
      ];
      selection.save_to_clipboard = true;
    };
  };
}
