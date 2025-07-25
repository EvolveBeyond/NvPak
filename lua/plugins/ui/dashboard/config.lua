return {
  dashboard = {
    enabled = true,
    config = function(opts)
      opts.header = {
        "███╗   ██╗██╗   ██╗██████╗  █████╗ ██╗  ██╗",
        "████╗  ██║██║   ██║██╔══██╗██╔══██╗██║ ██╔╝",
        "██╔██╗ ██║██║   ██║██████╔╝███████║█████╔╝ ",
        "██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██╔══██║██╔═██╗ ",
        "██║ ╚████║ ╚████╔╝ ██║     ██║  ██║██║  ██╗",
        "╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝",
      }
      opts.buttons = {
        { icon = "", text = "Update", key = "u", action = "Rocks sync" },
        { icon = "", text = "Files", key = "f", action = function() require("snacks").picker.files() end },
        { icon = "", text = "New file", key = "e", action = "enew" },
        { icon = "", text = "Quit Nvim", key = "q", action = "qa" },
      }
    end,
  },
}
