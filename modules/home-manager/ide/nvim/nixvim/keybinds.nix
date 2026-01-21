{
  keymaps = [
    {
      key = "<C-t>";
      mode = "n";
      action = "<Cmd>ToggleTerm size=15 name=ToggleTerm<CR>";
      options = {
        desc = "Open ToggleTerm";
      };
    }
    {
      key = "<Esc>";
      mode = "t";
      action = "<C-\\><C-n>";
    }
    {
      key = "<C-b>";
      mode = "n";
      action = "<Cmd>Neotree toggle action=show<CR>";
      options = {
        desc = "Open Neotree";
      };
    }
    {
      key = "<leader>bd";
      mode = "n";
      action = "<Cmd>wa | %bd! | e\# | bd\#<CR>";
      options = {
        desc = "Write and close all buffers, keeps current one open for editing";
      };
    }
    {
      key = "<leader>g";
      mode = "n";
      action = "<Cmd>LazyGit<CR>";
      options = {
        desc = "Open LazyGit";
      };
    }
    {
      key = "<leader>ff";
      mode = "n";
      action = "<Cmd>Telescope find_files<CR>";
      options = {
        desc = "Telescope find file";
      };
    }
    {
      key = "<leader>fg";
      mode = "n";
      action = "<Cmd>Telescope live_grep<CR>";
      options = {
        desc = "Telescope grep";
      };
    }
    {
      key = "<leader>cc";
      mode = "n";
      action = "<Cmd>CopilotChatToggle<CR>";
      options = {
        desc = "Toggle Copilot Chat";
      };
    }
    {
      key = "<leader>ce";
      mode = "n";
      action = "<Cmd>Copilot enable<CR>";
      options = {
        desc = "Enable Copilot Completions";
      };
    }
    {
      key = "<leader>cd";
      mode = "n";
      action = "<Cmd>Copilot disable<CR>";
      options = {
        desc = "Disable Copilot Completions";
      };
    }
    {
      key = "<leader>cs";
      mode = "n";
      action = "<Cmd>Copilot setup<CR>";
      options = {
        desc = "Setup Copilot Completions";
      };
    }
    {
      key = "<leader>mi";
      mode = "n";
      action = "<Cmd>MoltenInit<CR>";
      options = {
        desc = "Initialize Molten";
      };
    }
    {
      key = "<leader>ml";
      mode = "n";
      action = "<Cmd>MoltenEvaluateLine<CR>";
      options = {
        desc = "Evaluate Line";
      };
    }
    {
      key = "<leader>mo";
      mode = "n";
      action = "<Cmd>MoltenEvaluateOperator<CR>";
      options = {
        desc = "Evaluate Operator";
      };
    }
    {
      key = "<leader>mr";
      mode = "n";
      action = "<Cmd>MoltenReevaluateCell<CR>";
      options = {
        desc = "Reevaluate Cell";
      };
    }
    {
      key = "<leader>mv";
      mode = "v";
      action = "<Cmd>MoltenEvaluateVisual<CR>";
      options = {
        desc = "Evaluate Visual Selection";
      };
    }
    {
      key = "<leader>mh";
      mode = "n";
      action = "<Cmd>MoltenHideOutput<CR>";
      options = {
        desc = "Hide Output";
      };
    }
    {
      key = "<leader>me";
      mode = "n";
      action = "<Cmd>noautocmd MoltenEnterOutput<CR>";
      options = {
        desc = "Enter Output";
      };
    }
  ];
}
