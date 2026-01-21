{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      dap-ui.enable = true;
      dap = {
        enable = true;

        adapters = {
          executables = {};
          servers = {};
        };
      };
    };

    keymaps = [
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

    extraConfigLua = ''
      local dap = require("dap")
      dap.adapters.gdb = {
      	type = "executable",
      	command = "${pkgs.gdb}/bin/gdb",
      	args = {'--interpreter=dap', '--eval-command', 'set print pretty on'},
      }
      dap.adapters.python = {
      	type = "executable",
      	command = ".venv/bin/python",
      	-- command = "~/.conda/bin/python3.13",
      	args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.c = {
      	{
      		name = "Launch",
      		type = "gdb",
      		request = "launch",
      		program = function()
      			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      		end,
      		args = {}, -- provide arguments if needed
      		cwd = "''${workspaceFolder}",
      		stopAtBeginningOfMainSubprogram = false,
      	}
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

         dap.configurations.python = {
         	{
         		name = "Launch",
         		type = "python",
         		request = "launch",
           	program = "''${file}",
         		pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
         		-- pythonPath = '~/.conda/bin/python3.13',
         		env = {
         			LD_LIBRARY_PATH = os.getenv('LD_LIBRARY_PATH'),
         			NIX_LD_LIBRARY_PATH = os.getenv('NIX_LD_LIBRARY_PATH'),
         			NIX_LD = os.getenv('NIX_LD'),
         		},
         	}
         }

         -- Define helper functions for ToggleTerm and Neo-tree
         local function close_tools()
         	-- Close all toggleterm terminals
         	local ok_toggleterm, toggleterm = pcall(require, "toggleterm.terminal")
         	if ok_toggleterm then
         		for _, term in pairs(toggleterm.get_all()) do
         			term:close()
         		end
         	end

         	-- Close Neo-tree if it's open
         	local ok_neotree, neotree = pcall(require, "neo-tree.command")
         	if ok_neotree then
         		neotree.execute({ action = "close" })
         	end
         end

         local function reopen_tools()
         	-- Reopen Neo-tree
         	local ok_neotree, neotree = pcall(require, "neo-tree.command")
         	if ok_neotree then
         		neotree.execute({ action = "show" })
         	end
         end

         -- Attach listeners for DAP events
         dap.listeners.before.attach.dapui_config = function()
         	close_tools()
         	require('dapui').open()
         end

         dap.listeners.before.launch.dapui_config = function()
         	close_tools()
         	require('dapui').open()
         end

         dap.listeners.before.event_terminated.dapui_config = function()
         	require('dapui').close()
         	reopen_tools()
         end

         dap.listeners.before.event_exited.dapui_config = function()
         	require('dapui').close()
         	reopen_tools()
         end
    '';

    extraPlugins = [(pkgs.vimPlugins.telescope-dap-nvim)];
  };
}
