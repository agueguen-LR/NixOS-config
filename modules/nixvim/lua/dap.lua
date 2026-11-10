local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = _G.nix.dap.gdb,
	args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
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
		cwd = "${workspaceFolder}",
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
		program = "${file}",
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
