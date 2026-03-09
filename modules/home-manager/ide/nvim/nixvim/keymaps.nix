{
  programs.nixvim.keymaps = [
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

    # buffers
    {
      key = "<leader>bd";
      mode = "n";
      action = "<Cmd>wa | %bd! | e\# | bd\#<CR>";
      options = {
        desc = "Write and close all buffers, keeps current one open for editing";
      };
    }
    {
      key = "<leader>bl";
      mode = "n";
      action = "<Cmd>BufferLineCycleNext<CR>";
      options = {
        desc = "Open next buffer on BufferLine";
      };
    }
    {
      key = "<leader>bh";
      mode = "n";
      action = "<Cmd>BufferLineCyclePrev<CR>";
      options = {
        desc = "Open previous buffer on BufferLine";
      };
    }
    {
      key = "<leader>bs";
      mode = "n";
      action = "<Cmd>BufferLineSortByExtension<CR>";
      options = {
        desc = "Sort buffers on BufferLine by extension";
      };
    }
    {
      key = "<leader>bc";
      mode = "n";
      action = "<Cmd>BufferLineCloseOthers<CR>";
      options = {
        desc = "Close other buffers on BufferLine";
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

    # AI Copilot keybindings
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

    #Molten keybindings
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

    # DAP keybindings
    {
      mode = "n";
      key = "<leader>db";
      action = ":DapToggleBreakpoint<cr>";
      options = {
        silent = true;
        desc = "Toggle Breakpoint";
      };
    }
    {
      mode = "n";
      key = "<leader>dc";
      action = ":DapContinue<cr>";
      options = {
        silent = true;
        desc = "Continue";
      };
    }
    {
      mode = "n";
      key = "<leader>da";
      action = "<cmd>lua require('dap').continue({ before = get_args })<cr>";
      options = {
        silent = true;
        desc = "Run with Args";
      };
    }
    {
      mode = "n";
      key = "<leader>dC";
      action = "<cmd>lua require('dap').run_to_cursor()<cr>";
      options = {
        silent = true;
        desc = "Run to cursor";
      };
    }
    {
      mode = "n";
      key = "<leader>dg";
      action = "<cmd>lua require('dap').goto_()<cr>";
      options = {
        silent = true;
        desc = "Go to line (no execute)";
      };
    }
    {
      mode = "n";
      key = "<leader>di";
      action = ":DapStepInto<cr>";
      options = {
        silent = true;
        desc = "Step into";
      };
    }
    {
      mode = "n";
      key = "<leader>dj";
      action = "\n        <cmd>lua require('dap').down()<cr>\n      ";
      options = {
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = "n";
      key = "<leader>dk";
      action = "<cmd>lua require('dap').up()<cr>";
      options = {
        silent = true;
        desc = "Up";
      };
    }
    {
      mode = "n";
      key = "<leader>dl";
      action = "<cmd>lua require('dap').run_last()<cr>";
      options = {
        silent = true;
        desc = "Run Last";
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action = ":DapStepOut<cr>";
      options = {
        silent = true;
        desc = "Step Out";
      };
    }
    {
      mode = "n";
      key = "<leader>dO";
      action = ":DapStepOver<cr>";
      options = {
        silent = true;
        desc = "Step Over";
      };
    }
    {
      mode = "n";
      key = "<leader>dp";
      action = "<cmd>lua require('dap').pause()<cr>";
      options = {
        silent = true;
        desc = "Pause";
      };
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = ":DapToggleRepl<cr>";
      options = {
        silent = true;
        desc = "Toggle REPL";
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = "<cmd>lua require('dap').session()<cr>";
      options = {
        silent = true;
        desc = "Session";
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action = ":DapTerminate<cr>";
      options = {
        silent = true;
        desc = "Terminate";
      };
    }
    {
      mode = "n";
      key = "<leader>du";
      action = "<cmd>lua require('dapui').toggle()<cr>";
      options = {
        silent = true;
        desc = "Dap UI";
      };
    }
    {
      mode = "n";
      key = "<leader>dw";
      action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
      options = {
        silent = true;
        desc = "Widgets";
      };
    }
    {
      mode = ["n" "v"];
      key = "<leader>de";
      action = "<cmd>lua require('dapui').eval()<cr>";
      options = {
        silent = true;
        desc = "Eval";
      };
    }
    {
      mode = "n";
      key = "<leader>df";
      action = "<CMD>lua require('dap.ext.vscode').load_launchjs()<CR><CMD>Telescope dap configurations<CR>";
      options = {desc = "Debug Configurations";};
    }
  ];
}
