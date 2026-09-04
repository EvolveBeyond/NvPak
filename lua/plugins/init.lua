-- Setup Rocks Package Manager
require("plugins.rocks")
require("plugins.theme")

-- NvPak Home / Control Center
pcall(function()
  require("nvpak.home").setup()
end)

