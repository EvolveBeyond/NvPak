local M = {}
function M.get_snippet()
  local ms     = require('mini.snippets')
  local loader = ms.gen_loader
  ms.setup({
    snippets = {
      loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
      loader.from_lang(),
    },
  })
  -- Auto-create stub on MasonInstallEnd
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonInstallEnd',
    callback = function(evt)
      local lang = evt.data[1]
      local dir  = vim.fn.stdpath('config') .. '/snippets'
      vim.fn.mkdir(dir, 'p')
      local file = dir .. '/' .. lang .. '.json'
      if vim.fn.filereadable(file) == 0 then
        vim.fn.writefile({"{}"}, file)
        vim.notify('Created snippet config: ' .. file)
      end
    end,
  })
  -- SnipEdit command
  vim.api.nvim_create_user_command('SnipEdit', function(opts)
    local lang = opts.args
    local file = vim.fn.stdpath('config') .. '/snippets/' .. lang .. '.json'
    if vim.fn.filereadable(file) == 0 then
      vim.fn.writefile({"{}"}, file)
      vim.notify('Stub created: ' .. file)
    end
    vim.cmd('edit ' .. file)
  end, {
    nargs = 1,
    complete = function(_, input)
      return vim.fn.readdir(vim.fn.stdpath('config') .. '/snippets')
    end,
  })
  -- Return snippet expansion table
  return { expand = function(args) require('mini.snippets').default_expand(args) end }
end
return M

