local fn   = vim.fn
local uv   = vim.uv
local fs   = vim.fs

-- Determine OS-specific library extension
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
local lib_ext     = is_windows and "dll" or "so"

-- Base paths
local data_dir   = fn.stdpath("data")
local cache_dir  = fn.stdpath("cache")
local rocks_root = fs.joinpath(data_dir, "rocks")

-- rocks.nvim config
vim.g.rocks_nvim = {
  rocks_path = fs.normalize(rocks_root),
}

-- Extend Lua module search path
do
  local rp = vim.g.rocks_nvim.rocks_path
  local lua_paths = {
    fs.joinpath(rp, "share", "lua", "5.1", "?.lua"),
    fs.joinpath(rp, "share", "lua", "5.1", "?", "init.lua"),
  }
  package.path = package.path .. ";" .. table.concat(lua_paths, ";")

  local c_paths = {
    fs.joinpath(rp, "lib",  "lua", "5.1", "?." .. lib_ext),
    fs.joinpath(rp, "lib64","lua", "5.1", "?." .. lib_ext),
  }
  package.cpath = package.cpath .. ";" .. table.concat(c_paths, ";")

  -- Add all installed rocks (including rocks.nvim) to runtimepath
  local bundle = fs.joinpath(rp, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*")
  vim.opt.runtimepath:append(bundle)
end

-- Bootstrap rocks.nvim if not already installed
if not pcall(require, "rocks") then
  local bootstrap_dir = fs.joinpath(cache_dir, "rocks.nvim")

  if not uv.fs_stat(bootstrap_dir) then
    vim.fn.system({
      "git", "clone", "--filter=blob:none",
      "https://github.com/nvim-neorocks/rocks.nvim",
      bootstrap_dir,
    })
  end

  assert(vim.v.shell_error == 0, "rocks.nvim installation failed")
  vim.cmd.source(fs.joinpath(bootstrap_dir, "bootstrap.lua"))
  vim.fn.delete(bootstrap_dir, "rf")
end

