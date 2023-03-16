local dict = require("cmp_dictionary")

dict.setup({
  -- The following are default values.
  exact = 2,
  first_case_insensitive = false,
  document = false,
  document_command = "wn %s -over",
  async = false,
  max_items = -1,
  capacity = 5,
  debug = false,
})

dict.switcher({
spelllang = {
    en = "~/.config/nvim/spell/english.dict",
  },
})
