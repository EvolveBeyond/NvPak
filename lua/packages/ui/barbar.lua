-- Set kaybinds
require("packages.bindings.barbar")
-- Set barbar's options
local barbar = require("bufferline")

-- set config variables
local config = {
	auto_hide = false,
	tabpages = true,
}

-- enable barbar
barbar.setup(config)
