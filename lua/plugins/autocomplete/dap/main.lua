-- Importing dap and dapui modules using destructuring assignment
local dap, dapui = require("dap"), require("dapui")
local mason_dap = require("mason-nvim-dap")

-- Configuration settings for the debugging environment
local DEFAULT_SETTINGS = {
	-- List of adapters to ensure are installed
	ensure_installed = { "lua", "rust", "python" },
	-- Whether to automatically install adapters that are set up via dap
	automatic_installation = true,
	-- Whether to automatically set up adapters that are installed in mason
	automatic_setup = true,
}

-- Handler function to manage the dapui interface
local function dapui_config(event)
	-- If the event is event_initialized, open the dapui interface
	if event.name == "event_initialized" then
		dapui.open()
		-- Otherwise, close the dapui interface
	else
		dapui.close()
	end
end

-- Set up listeners for dap events
dap.listeners.after[dap.listeners.after.event_initialized] = dapui_config
dap.listeners.before[dap.listeners.before.event_terminated] = dapui_config
dap.listeners.before[dap.listeners.before.event_exited] = dapui_config

-- Set up the debugging environment
mason_dap.setup(DEFAULT_SETTINGS)
